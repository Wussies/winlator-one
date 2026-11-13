package com.winlator.cmod.app

/**
 * NEXORA security and compliance policy switches.
 *
 * These are compile-time constants on purpose: features listed here are not
 * user-toggleable, and the UI that used to expose them is hidden. Every flag
 * is documented in SECURITY_AUDIT.md.
 */
object NexoraPolicy {
    /**
     * gbe_fork / Goldberg Steam API emulation, ColdClient and Steamless
     * (SteamStub removal) are DRM circumvention and are not shipped (WN-2).
     */
    const val DRM_CIRCUMVENTION_ENABLED = false

    /**
     * The upstream "Bionic Steam" launcher drives Valve's Steam client
     * binaries, which upstream bundled in the APK. NEXORA does not
     * redistribute them (WN-3). Until NEXORA downloads the official client
     * from Valve on the device, this launch path stays off.
     */
    const val OFFICIAL_STEAM_CLIENT_AVAILABLE = false

    /** Steam sign-in by username/password inside the app is not allowed; QR only (WN-7). */
    const val STEAM_PASSWORD_LOGIN_ENABLED = false

    /**
     * Remote component/profile catalogs from personal or upstream repositories
     * are unsigned and mutable (WN-4). Users can still import local files.
     */
    const val REMOTE_COMPONENT_CATALOGS_ENABLED = false

    /** The upstream self-updater targets WinNative releases, not NEXORA. */
    const val UPSTREAM_UPDATER_ENABLED = false
}
