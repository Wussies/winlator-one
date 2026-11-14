package com.winlator.cmod.runtime.display.environment

import android.content.Context
import android.text.format.Formatter
import com.winlator.cmod.R

/** NEXORA: user-facing text for [ImageFsInstaller.Failure]. */
object ImageFsInstallMessages {
    @JvmStatic
    fun describe(
        context: Context,
        failure: ImageFsInstaller.Failure,
        detail: String?,
    ): String =
        when (failure) {
            ImageFsInstaller.Failure.ALREADY_RUNNING ->
                context.getString(R.string.nexora_imagefs_already_running)
            ImageFsInstaller.Failure.INSUFFICIENT_STORAGE -> {
                val bytes = detail?.toLongOrNull() ?: 0L
                context.getString(
                    R.string.nexora_imagefs_no_space,
                    Formatter.formatShortFileSize(context, bytes),
                )
            }
            ImageFsInstaller.Failure.MISSING_ARCHIVE ->
                context.getString(R.string.nexora_imagefs_missing_archive)
            ImageFsInstaller.Failure.EXTRACTION_FAILED ->
                context.getString(R.string.nexora_imagefs_extract_failed)
            ImageFsInstaller.Failure.UNEXPECTED ->
                context.getString(R.string.nexora_imagefs_unexpected, detail ?: "?")
        }
}
