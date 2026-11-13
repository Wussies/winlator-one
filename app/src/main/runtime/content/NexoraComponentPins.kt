package com.winlator.cmod.runtime.content

import android.util.Log
import com.winlator.cmod.app.NexoraPolicy
import org.json.JSONArray
import org.json.JSONObject
import java.io.File
import java.security.MessageDigest
import java.util.Locale

/**
 * NEXORA's verified component catalog.
 *
 * Upstream WinNative downloads Wine/Proton/DXVK/VKD3D/Box64/FEX packages from a
 * personal GitHub account, using a mutable JSON list and no integrity check.
 * NEXORA instead ships a fixed list: every package was downloaded once,
 * scanned (ClamAV) and inventoried in CI, mirrored to this repository's release
 * "nexora-components-2", and is accepted only if its SHA-256 and size match.
 *
 * Entries keep the original upstream URL as their identity ("remoteUrl"), so
 * the rest of the upstream code (installed-state tracking, UI) keeps working.
 */
object NexoraComponentPins {
    private const val TAG = "NexoraComponentPins"
    private const val MIRROR = "https://github.com/Wussies/winlator-one/releases/download/nexora-components-2/"

    data class Pin(
        val fileName: String,
        val type: String,
        val verName: String,
        val upstreamUrl: String,
        val sha256: String,
        val size: Long,
    ) {
        val mirrorUrl: String get() = MIRROR + fileName
    }

    // Filled from the CI mirror report (audit/results/runtime-components/SHA256SUMS).
    val pins: List<Pin> = NexoraComponentPinsData.PINS

    private val byFileName: Map<String, Pin> =
        pins.associateBy { it.fileName.lowercase(Locale.ROOT) }

    fun findByUrl(url: String?): Pin? {
        if (url.isNullOrBlank()) return null
        val name = url.substringAfterLast('/').substringBefore('?').lowercase(Locale.ROOT)
        return byFileName[name]
    }

    fun isPinned(url: String?): Boolean = findByUrl(url) != null

    /** Catalog in the upstream contents.json / default.json format. */
    fun catalogJson(): String {
        val array = JSONArray()
        for (pin in pins) {
            array.put(
                JSONObject()
                    .put("type", pin.type)
                    .put("verName", pin.verName)
                    .put("verCode", 0)
                    .put("remoteUrl", pin.upstreamUrl)
                    .put("official", true),
            )
        }
        return array.toString()
    }

    /**
     * Downloads a pinned component from the NEXORA mirror and verifies it.
     * Returns false (and leaves no file behind) for unknown or mismatching files.
     */
    fun download(url: String, target: File, listener: Downloader.DownloadListener?): Boolean {
        val pin = findByUrl(url)
        if (pin == null) {
            Log.w(TAG, "Refusing download of unpinned component: $url")
            return false
        }
        if (!Downloader.downloadFile(pin.mirrorUrl, target, listener)) {
            target.delete()
            return false
        }
        if (target.length() != pin.size || sha256(target) != pin.sha256) {
            Log.e(TAG, "Integrity check failed for ${pin.fileName}; file discarded")
            target.delete()
            return false
        }
        return true
    }

    /** True when remote (unpinned) catalogs must not be used. */
    val enforced: Boolean get() = !NexoraPolicy.REMOTE_COMPONENT_CATALOGS_ENABLED

    fun sha256(file: File): String {
        val digest = MessageDigest.getInstance("SHA-256")
        file.inputStream().use { input ->
            val buffer = ByteArray(1 shl 16)
            while (true) {
                val read = input.read(buffer)
                if (read < 0) break
                digest.update(buffer, 0, read)
            }
        }
        return digest.digest().joinToString("") { "%02x".format(it) }
    }
}
