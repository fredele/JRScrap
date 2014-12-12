// This file is part of the JRScrap project.

// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit MC_Commands_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages;

const

  WM_MC_COMMAND: integer = WM_APP + 1000;

  MCC_PLAY_PAUSE: integer = 10000;
  MCC_PLAY: integer = 10001;
  MCC_STOP: integer = 10002;
  MCC_NEXT: integer = 10003;
  MCC_PREVIOUS: integer = 10004;
  MCC_SHUFFLE: integer = 10005;
  MCC_CONTINUOUS: integer = 10006;
  MCC_OBSOLETE_10007: integer = 10007;
  MCC_FAST_FORWARD: integer = 10008;
  MCC_REWIND: integer = 10009;
  MCC_STOP_CONDITIONAL: integer = 10010;
  MCC_SET_ZONE: integer = 10011;
  MCC_TOGGLE_DISPLAY: integer = 10012;
  MCC_SHOW_WINDOW: integer = 10013;
  MCC_MINIMIZE_WINDOW: integer = 10014;
  MCC_PLAY_CPLDB_INDEX: integer = 10015;
  MCC_SHOW_DSP_STUDIO: integer = 10016;
  MCC_VOLUME_MUTE: integer = 10017;
  MCC_VOLUME_UP: integer = 10018;
  MCC_VOLUME_DOWN: integer = 10019;
  MCC_VOLUME_SET: integer = 10020;
  MCC_SHOW_PLAYBACK_OPTIONS: integer = 10021;
  MCC_SET_PAUSE: integer = 10022;
  MCC_SET_CURRENTLY_PLAYING_RATING: integer = 10023;
  MCC_SHOW_PLAYBACK_ENGINE_MENU: integer = 10024;
  MCC_PLAY_NEXT_PLAYLIST: integer = 10025;
  MCC_PLAY_PREVIOUS_PLAYLIST: integer = 10026;
  MCC_MAXIMIZE_WINDOW: integer = 10027;
  MCC_RESTORE_WINDOW: integer = 10028;
  MCC_SET_PLAYERSTATUS: integer = 10029;
  MCC_SET_ALTERNATE_PLAYBACK_SETTINGS: integer = 10030;
  MCC_SET_PREVIEW_MODE_SETTINGS: integer = 10031;
  MCC_SHOW_PLAYBACK_ENGINE_DISPLAY_PLUGIN_MENU: integer = 10032;
  MCC_DVD_MENU: integer = 10033;
  MCC_SEEK_FORWARD: integer = 10034;
  MCC_SEEK_BACK: integer = 10035;
  MCC_STOP_AFTER_CURRENT_FILE: integer = 10036;
  MCC_DETACH_DISPLAY: integer = 10037;
  MCC_SET_MODE_ZONE_SPECIFIC: integer = 10038;
  MCC_STOP_INTERNAL: integer = 10039;
  MCC_PLAYING_NOW_REMOVE_DUPLICATES: integer = 10040;
  MCC_SHUFFLE_REMAINING: integer = 10041;
  MCC_PLAY_FIRST_FILE: integer = 10042;
  MCC_PLAY_LAST_FILE: integer = 10043;
  MCC_PLAY_FILE_BY_STRING: integer = 10044;
  MCC_PLAY_FILE_AGAIN: integer = 10045;
  MCC_HANDLE_PLAYBACK_ERROR: integer = 10046;
  MCC_PLAY_AUTOMATIC_PLAYLIST: integer = 10047;
  MCC_SEEK: integer = 10048;
  MCC_CLEAR_PLAYING_NOW_ZONE_SPECIFIC: integer = 10049;
  MCC_PLAY_RADIO_LAST_FM: integer = 10050;
  MCC_SHOW_ON_SCREEN_DISPLAY: integer = 10051;
  MCC_SET_SUBTITLES: integer = 10052;
  MCC_SET_AUDIO_STREAM: integer = 10053;
  MCC_SET_VIDEO_STREAM: integer = 10054;
  MCC_VIDEO_SCREEN_GRAB: integer = 10055;
  MCC_SET_VOLUME_MODE: integer = 10056;
  MCC_RESTART_PLAYBACK: integer = 10057;
  MCC_ZONE_SWITCH: integer = 10058;
  MCC_SKIP_TO: integer = 10059;
  MCC_LINK_ZONE: integer = 10060;
  MCC_UNLINK_ZONE: integer = 10061;
  MCC_OPEN_FILE: integer = 20000;
  MCC_OPEN_URL: integer = 20001;
  MCC_PRINT_LIST: integer = 20002;
  MCC_EXPORT_PLAYLIST: integer = 20003;
  MCC_EXPORT_ALL_PLAYLISTS: integer = 20004;
  MCC_UPLOAD_FILES: integer = 20005;
  MCC_EMAIL_FILES: integer = 20006;
  MCC_EXIT: integer = 20007;
  MCC_UPDATE_LIBRARY: integer = 20008;
  MCC_CLEAR_LIBRARY: integer = 20009;
  MCC_EXPORT_LIBRARY: integer = 20010;
  MCC_BACKUP_LIBRARY: integer = 20011;
  MCC_RESTORE_LIBRARY: integer = 20012;
  MCC_LIBRARY_MANAGER: integer = 20013;
  MCC_IMAGE_ACQUIRE: integer = 20014;
  MCC_PRINT_IMAGES: integer = 20015;
  MCC_PRINT: integer = 20016;
  MCC_OBSOLETE_20017: integer = 20017;
  MCC_OBSOLETE_20018: integer = 20018;
  MCC_OBSOLETE_20019: integer = 20019;
  MCC_OBSOLETE_20020: integer = 20020;
  MCC_OBSOLETE_20021: integer = 20021;
  MCC_OBSOLETE_20022: integer = 20022;
  MCC_OBSOLETE_20023: integer = 20023;
  MCC_IMPORT_PLAYLIST: integer = 20024;
  MCC_LOAD_LIBRARY: integer = 20025;
  MCC_SYNC_LIBRARY: integer = 20026;
  MCC_EMAIL_PODCAST_FEED: integer = 20027;
  MCC_LOAD_LIBRARY_READ_ONLY: integer = 20028;
  MCC_ADD_LIBRARY: integer = 20029;
  MCC_EXPORT_ITUNES: integer = 20030;
  MCC_DISCONNECT_LIBRARY: integer = 20031;
  MCC_SYNC_WITH_LIBRARY_SERVER: integer = 20032;
  MCC_STOP_ALL_ZONES: integer = 20033;
  MCC_CLONE_LIBRARY: integer = 20034;
  MCC_OPEN_LIVE: integer = 20035;
  MCC_COPY: integer = 21000;
  MCC_PASTE: integer = 21001;
  MCC_SELECT_ALL: integer = 21002;
  MCC_SELECT_INVERT: integer = 21003;
  MCC_DELETE: integer = 21004;
  MCC_RENAME: integer = 21005;
  MCC_UNDO: integer = 21006;
  MCC_REDO: integer = 21007;
  MCC_QUICK_SEARCH: integer = 21008;
  MCC_ADD_PLAYLIST: integer = 21009;
  MCC_ADD_SMARTLIST: integer = 21010;
  MCC_ADD_PLAYLIST_GROUP: integer = 21011;
  MCC_PROPERTIES: integer = 21012;
  MCC_TOGGLE_TAGGING_MODE: integer = 21013;
  MCC_CUT: integer = 21014;
  MCC_DESELECT_ALL: integer = 21015;
  MCC_DELETE_ALL: integer = 21016;
  MCC_ADD_PODCAST_FEED: integer = 21017;
  MCC_EDIT_PODCAST_FEED: integer = 21018;
  MCC_ADD_PODCAST_DEFAULTS: integer = 21019;
  MCC_CREATE_STOCK_SMARTLISTS: integer = 21020;
  MCC_ENABLE_PODCAST_DOWNLOAD: integer = 21021;
  MCC_DISABLE_PODCAST_DOWNLOAD: integer = 21022;
  MCC_EDIT_PLAYLIST: integer = 21023;
  MCC_EDIT_PLAYING_NOW: integer = 21024;
  MCC_EDIT_DISC_INFORMATION: integer = 21025;
  MCC_EDIT_SMARTLIST: integer = 21026;
  MCC_REFRESH_PODCAST_FEED: integer = 21027;
  MCC_LOOKUP_MOVIE_INFORMATION: integer = 21028;
  MCC_ADD_ZONE: integer = 21029;
  MCC_ADD_AUTOMATIC_PLAYLIST: integer = 21030;
  MCC_SET_WRITE_TAGS: integer = 21031;
  MCC_PASTE_TAGS: integer = 21032;
  MCC_TOGGLE_MODE: integer = 22000;
  MCC_THEATER_VIEW: integer = 22001;
  MCC_PARTY_MODE: integer = 22002;
  MCC_SHOW_TREE_ROOT: integer = 22003;
  MCC_FIND_MEDIA: integer = 22004;
  MCC_BACK: integer = 22005;
  MCC_FORWARD: integer = 22006;
  MCC_REFRESH: integer = 22007;
  MCC_SET_LIST_STYLE: integer = 22008;
  MCC_SET_MODE: integer = 22009;
  MCC_OBSOLETE_22010: integer = 22010;
  MCC_OBSOLETE_22011: integer = 22011;
  MCC_SHOW_RECENTLYIMPORTED: integer = 22012;
  MCC_SHOW_TOPHITS: integer = 22013;
  MCC_SHOW_RECENTLYPLAYED: integer = 22014;
  MCC_SET_MEDIA_MODE: integer = 22015;
  MCC_OBSOLETE_22016: integer = 22016;
  MCC_SET_SERVER_MODE: integer = 22017;
  MCC_SET_MODE_FOR_EXTERNAL_PROGRAM_LAUNCH: integer = 22018;
  MCC_SET_MODE_FOR_SECOND_INSTANCE_LAUNCH: integer = 22019;
  MCC_HOME: integer = 22020;
  MCC_ROLLUP_VIEW_HEADER: integer = 22021;
  MCC_FOCUS_SEARCH_CONTROL: integer = 22022;
  MCC_SET_ACTIVE_VIEW_KEY: integer = 22023;
  MCC_CLOSE_VIEW_KEY: integer = 22024;
  MCC_VIEW_ZOOM_SET: integer = 22025;
  MCC_VIEW_ZOOM_INCREMENT: integer = 22026;
  MCC_FIND_MEDIA_WITH_WIZARD: integer = 22027;
  MCC_SET_USER: integer = 22028;
  MCC_SHOW_TREE: integer = 22029;
  MCC_IMPORT: integer = 23000;
  MCC_RIP_CD: integer = 23001;
  MCC_BURN: integer = 23002;
  MCC_RECORD_AUDIO: integer = 23003;
  MCC_CONVERT: integer = 23004;
  MCC_ANALYZE_AUDIO: integer = 23005;
  MCC_MEDIA_EDITOR: integer = 23006;
  MCC_CD_LABELER: integer = 23007;
  MCC_OBSOLETE_23008: integer = 23008;
  MCC_OBSOLETE_23009: integer = 23009;
  MCC_SKIN_MANAGER: integer = 23010;
  MCC_OPTIONS: integer = 23011;
  MCC_RENAME_CD_FILES: integer = 23012;
  MCC_OBSOLETE_23013: integer = 23013;
  MCC_OBSOLETE_23014: integer = 23014;
  MCC_HANDHELD_UPLOAD: integer = 23015;
  MCC_HANDHELD_UPDATE_UPLOAD_WORKER_FINISHED: integer = 23016;
  MCC_HANDHELD_CLOSE_DEVICE: integer = 23017;
  MCC_HANDHELD_SHOW_OPTIONS: integer = 23018;
  MCC_HANDHELD_INFO_DUMP: integer = 23019;
  MCC_IMPORT_AUTO_RUN_NOW: integer = 23020;
  MCC_IMPORT_AUTO_CONFIGURE: integer = 23021;
  MCC_HANDHELD_EJECT: integer = 23022;
  MCC_RECORD_TV: integer = 23023;
  MCC_FIND_AND_REPLACE: integer = 23024;
  MCC_CLEAN_PROPERTIES: integer = 23025;
  MCC_FILL_TRACK_ORDER: integer = 23026;
  MCC_MOVE_COPY_FIELDS: integer = 23027;
  MCC_REMOVE_TAGS: integer = 23028;
  MCC_UPDATE_TAGS_FROM_DB: integer = 23029;
  MCC_UPDATE_DB_FROM_TAGS: integer = 23030;
  MCC_LOOKUP_TRACK_INFO_FROM_INTERNET: integer = 23031;
  MCC_SUBMIT_TRACK_INFO_TO_INTERNET: integer = 23032;
  MCC_OBSOLETE_23033: integer = 23033;
  MCC_FILL_PROPERTIES_FROM_FILENAME: integer = 23034;
  MCC_RENAME_FILES_FROM_PROPERTIES: integer = 23035;
  MCC_COVER_ART_ADD_FROM_FILE: integer = 23036;
  MCC_COVER_ART_QUICK_ADD_FROM_FILE: integer = 23037;
  MCC_COVER_ART_GET_FROM_INTERNET: integer = 23038;
  MCC_COVER_ART_SUBMIT_TO_INTERNET: integer = 23039;
  MCC_COVER_ART_GET_FROM_SCANNER: integer = 23040;
  MCC_COVER_ART_SELECT_SCANNER: integer = 23041;
  MCC_COVER_ART_GET_FROM_CLIPBOARD: integer = 23042;
  MCC_COVER_ART_COPY_TO_CLIPBOARD: integer = 23043;
  MCC_COVER_ART_REMOVE: integer = 23044;
  MCC_COVER_ART_PLAY: integer = 23045;
  MCC_COVER_ART_SAVE_TO_EXTERNAL_FILE: integer = 23046;
  MCC_COVER_ART_REBUILD_THUMBNAIL: integer = 23047;
  MCC_RINGTONE: integer = 23048;
  MCC_AUDIO_CALIBRATION: integer = 23049;
  MCC_HELP_CONTENTS: integer = 24000;
  MCC_HELP_HOWTO_IMPORT_FILES: integer = 24001;
  MCC_HELP_HOWTO_PLAY_FILES: integer = 24002;
  MCC_HELP_HOWTO_RIP: integer = 24003;
  MCC_HELP_HOWTO_BURN: integer = 24004;
  MCC_HELP_HOWTO_ORGANIZE_FILES: integer = 24005;
  MCC_HELP_HOWTO_VIEW_SCHEMES: integer = 24006;
  MCC_HELP_HOWTO_MANAGE_PLAYLISTS: integer = 24007;
  MCC_HELP_HOWTO_EDIT_PROPERTIES: integer = 24008;
  MCC_HELP_HOWTO_FIND: integer = 24009;
  MCC_HELP_HOWTO_CONFIGURE: integer = 24010;
  MCC_CHECK_FOR_UPDATES: integer = 24011;
  MCC_BUY: integer = 24012;
  MCC_INSTALL_LICENSE: integer = 24013;
  MCC_REGISTRATION_INFO: integer = 24014;
  MCC_PLUS_FEATURES: integer = 24015;
  MCC_INTERACT: integer = 24016;
  MCC_SYSTEM_INFO: integer = 24017;
  MCC_ABOUT: integer = 24018;
  MCC_CONFIGURE_DEBUG_LOGGING: integer = 24019;
  MCC_WIKI: integer = 24020;
  MCC_TEST: integer = 24021;
  MCC_SHOW_EULA: integer = 24022;
  MCC_BENCHMARK: integer = 24023;
  MCC_ADD_VIEW_SCHEME: integer = 25000;
  MCC_EDIT_VIEW_SCHEME: integer = 25001;
  MCC_OBSOLETE_25002: integer = 25002;
  MCC_OBSOLETE_25003: integer = 25003;
  MCC_OBSOLETE_25004: integer = 25004;
  MCC_OBSOLETE_25005: integer = 25005;
  MCC_OBSOLETE_25006: integer = 25006;
  MCC_OBSOLETE_25007: integer = 25007;
  MCC_TREE_ADD_DIRECTORY: integer = 25008;
  MCC_TREE_IMPORT: integer = 25009;
  MCC_TREE_ADD_CD_FOLDER: integer = 25010;
  MCC_UPDATE_FROM_CD_DATABASE: integer = 25011;
  MCC_SUBMIT_TO_CD_DATABASE: integer = 25012;
  MCC_TREE_RIP: integer = 25013;
  MCC_CLEAR_PLAYING_NOW: integer = 25014;
  MCC_COPY_LISTENING_TO: integer = 25015;
  MCC_TREE_SET_EXPANDED: integer = 25016;
  MCC_RESET_VIEW_SCHEMES: integer = 25017;
  MCC_TREE_ERASE_CD_DVD: integer = 25018;
  MCC_UPDATE_FROM_CDPLAYER_INI: integer = 25019;
  MCC_TREE_EJECT: integer = 25020;
  MCC_TREE_ADD_VIRTUAL_DEVICE: integer = 25021;
  MCC_TREE_RENAME_PLAYLIST: integer = 25022;
  MCC_TWITTER_LISTENING_TO: integer = 25023;
  MCC_SCROBBLE_LISTENING_TO: integer = 25024;
  MCC_LIST_UPDATE_ORDER: integer = 26000;
  MCC_LIST_SHUFFLE_ORDER: integer = 26001;
  MCC_LIST_IMPORT: integer = 26002;
  MCC_LIST_REMOVE_ORDER: integer = 26003;
  MCC_LOCATE_FILE: integer = 26004;
  MCC_LIST_OBSOLETE_26005: integer = 26005;
  MCC_LIST_INCREMENT_SELECTION: integer = 26006;
  MCC_LIST_REMOVE_DUPLICATES: integer = 26007;
  MCC_LIST_AUTO_SIZE_COLUMN: integer = 26008;
  MCC_LIST_CUSTOMIZE_VIEW: integer = 26009;
  MCC_LIST_COPY_DISK_FILES: integer = 26010;
  MCC_LIST_SET_RIP_CHECK: integer = 26011;
  MCC_LIST_DOWNLOAD: integer = 26012;
  MCC_LIST_GET_LIST_POINTER: integer = 26013;
  MCC_LOCATE_STACK: integer = 26014;
  MCC_SET_AS_STACK_TOP: integer = 26015;
  MCC_EXPAND_STACK: integer = 26016;
  MCC_COLLAPSE_STACK: integer = 26017;
  MCC_AUTOSTACK: integer = 26018;
  MCC_CHECK_STACKS: integer = 26019;
  MCC_STACK: integer = 26020;
  MCC_UNSTACK: integer = 26021;
  MCC_ADD_TO_STACK: integer = 26022;
  MCC_PANE_RESET_SELECTION: integer = 26023;
  MCC_LIST_REMOVE_ALL: integer = 26024;
  MCC_LIST_LOCK: integer = 26025;
  MCC_PANE_SET_EXPANDED: integer = 26026;
  MCC_KEYSTROKE: integer = 27000;
  MCC_SHUTDOWN: integer = 27001;
  MCC_PLAYBACK_ENGINE_ZOOM_IN: integer = 28000;
  MCC_PLAYBACK_ENGINE_ZOOM_OUT: integer = 28001;
  MCC_PLAYBACK_ENGINE_UP: integer = 28002;
  MCC_PLAYBACK_ENGINE_DOWN: integer = 28003;
  MCC_PLAYBACK_ENGINE_LEFT: integer = 28004;
  MCC_PLAYBACK_ENGINE_RIGHT: integer = 28005;
  MCC_PLAYBACK_ENGINE_ENTER: integer = 28006;
  MCC_PLAYBACK_ENGINE_FIRST: integer = 28007;
  MCC_PLAYBACK_ENGINE_LAST: integer = 28008;
  MCC_PLAYBACK_ENGINE_NEXT: integer = 28009;
  MCC_PLAYBACK_ENGINE_PREVIOUS: integer = 28010;
  MCC_PLAYBACK_ENGINE_PAUSE: integer = 28011;
  MCC_IMAGE_PAN_AND_ZOOM: integer = 28012;
  MCC_IMAGE_TOGGLE_EFFECT: integer = 28013;
  MCC_IMAGE_RAPID_ZOOM: integer = 28014;
  MCC_DVD_SET_AUDIO_STREAM: integer = 28015;
  MCC_DVD_SHOW_MENU: integer = 28016;
  MCC_TV_RECORD: integer = 28017;
  MCC_TV_SNAPSHOT: integer = 28018;
  MCC_TV_CHANGE_STANDARD: integer = 28019;
  MCC_PLAYBACK_ENGINE_OSD_VIDEO_PROC_AMP: integer = 28020;
  MCC_PLAYBACK_ENGINE_SET_CUR_VIDEO_PROC_AMP: integer = 28021;
  MCC_PLAYBACK_ENGINE_SET_ASPECT_RATIO: integer = 28022;
  MCC_PLAYBACK_ENGINE_SCROLL_UP: integer = 28023;
  MCC_PLAYBACK_ENGINE_SCROLL_DOWN: integer = 28024;
  MCC_PLAYBACK_ENGINE_SCROLL_LEFT: integer = 28025;
  MCC_PLAYBACK_ENGINE_SCROLL_RIGHT: integer = 28026;
  MCC_TV_SET_SAVE_TIME_SHIFTING: integer = 28027;
  MCC_PLAYBACK_ENGINE_ZOOM_TO_PRESET: integer = 28028;
  MCC_TV_SCAN_PROGRAMMING_EVENTS: integer = 28029;
  MCC_TV_CHANGE_CHANNEL_KEY: integer = 28030;
  MCC_TV_PLAY_CHANNEL_POSITION: integer = 28031;
  MCC_PLAYBACK_ENGINE_SET_SUBTITLES: integer = 28032;
  MCC_PLAYBACK_ENGINE_SET_AUDIO_STREAM: integer = 28033;
  MCC_PLAYBACK_ENGINE_SET_VIDEO_STREAM: integer = 28034;
  MCC_PLAYBACK_ENGINE_VIDEO_SCREEN_GRAB: integer = 28035;
  MCC_RELOAD_MC_VIEW: integer = 30000;
  MCC_CUSTOMIZE_TOOLBAR: integer = 30001;
  MCC_PLAY_TV: integer = 30002;
  MCC_UPDATE_WEBPAGES: integer = 30003;
  MCC_SHOW_RUNNING_MC: integer = 30004;
  MCC_SHOW_MENU: integer = 30005;
  MCC_TUNE_TV: integer = 30006;
  MCC_PLAY_PLAYLIST: integer = 30007;
  MCC_SENDTO_TOOL: integer = 30008;
  MCC_SHOW_VIEW_INFO: integer = 30009;
  MCC_OBSOLETE_30010: integer = 30010;
  MCC_DEVICE_CHANGED: integer = 30011;
  MCC_CONFIGURE_THEATER_VIEW: integer = 30012;
  MCC_SET_STATUSTEXT: integer = 30013;
  MCC_UPDATE_UI_AFTER_ACTIVE_WINDOW_CHANGE: integer = 30014;
  MCC_REENUM_PORTABLE_DEVICES: integer = 30015;
  MCC_PLAY_ADVANCED: integer = 30016;
  MCC_UPDATE_STATUS_BAR: integer = 30017;
  MCC_REQUEST_PODCAST_UPDATE: integer = 30018;
  MCC_REQUEST_PODCAST_PURGE: integer = 30019;
  MCC_OBSOLETE_30020: integer = 30020;
  MCC_SHOW_INVALID_CD_VOLUME_WARNING: integer = 30021;
  MCC_PLAY_TV_CHANNEL_FOR_CLIENT: integer = 30022;
  MCC_STOP_SERVING_TV_FILE: integer = 30023;
  MCC_SHOW_DEVICE_PRESENTATION_WEBPAGE: integer = 30024;
  MCC_IMAGE_SET_DESKTOP_BACK: integer = 31000;
  MCC_IMAGE_ROTATE_LEFT: integer = 31001;
  MCC_IMAGE_ROTATE_RIGHT: integer = 31002;
  MCC_IMAGE_ROTATE_UPSIDEDOWN: integer = 31003;
  MCC_IMAGE_RESIZE: integer = 31004;
  MCC_IMAGE_EDIT: integer = 31005;
  MCC_IMAGE_DELETE: integer = 31006;
  MCC_IMAGE_PREVIEW_SHOW: integer = 31007;
  MCC_IMAGE_PREVIEW_HIDE: integer = 31008;
  MCC_IMAGE_LOCATE_ON_MAP: integer = 31009;
  MCC_QUERY_UI_MODE: integer = 32000;
  MCC_GET_SELECTED_FILES: integer = 33000;
  MCC_PRINTVIEW: integer = 33001;
  MCC_OUTPUT: integer = 33002;
  MCC_SETFOCUS: integer = 33003;
  MCC_SELECT_FILES: integer = 33004;
  MCC_DOUBLE_CLICK: integer = 33005;
  MCC_PLAY_OR_SHOW: integer = 33006;
  MCC_SHOW_CURRENT_FILE: integer = 33007;
  MCC_BUY_SELECTED_TRACKS: integer = 33008;
  MCC_BUY_ALL_TRACKS: integer = 33009;
  MCC_BUY_ALBUM: integer = 33010;
  MCC_UPDATE_AFTER_PLUGIN_INSTALLED: integer = 33011;
  MCC_UPDATE_AFTER_SKIN_INSTALLED: integer = 33012;
  MCC_NOTIFY_UI_CHANGED: integer = 34000;
  MCC_NOTIFY_VIEW_CHANGED: integer = 34001;
  MCC_NOTIFY_BEFORE_ACTIVE_VIEW_CHANGED: integer = 34002;
  MCC_NOTIFY_ACTIVE_VIEW_CHANGED: integer = 34003;
  MCC_NOTIFY_PLAYER_INFO_CHANGED: integer = 34004;
  MCC_NOTIFY_TOOLTIPS_CHANGED: integer = 34005;
  MCC_NOTIFY_OPTIONS_CHANGED: integer = 34006;
  MCC_UPDATE: integer = 34007;
  MCC_NOTIFY_FOCUS_CHANGED: integer = 34008;
  MCC_SAVE_PROPERTIES: integer = 34009;
  MCC_NOTIFY_UI_MODE_CHANGED: integer = 34010;
  MCC_NOTIFY_SELECTION_CHANGED: integer = 34011;
  MCC_NOTIFY_FILE_CHANGED: integer = 34012;
  MCC_NOTIFY_FILE_STATUS_CHANGED: integer = 34013;
  MCC_NOTIFY_FILE_ENSURE_VISIBLE: integer = 34014;
  MCC_NOTIFY_GET_TAB_HWNDS: integer = 34015;
  MCC_NOTIFY_BURNER_QUEUE_CHANGED: integer = 34016;
  MCC_NOTIFY_BURNER_PROGRESS_CHANGED: integer = 34017;
  MCC_NOTIFY_BURNER_STATUS_CHANGED: integer = 34018;
  MCC_NOTIFY_BURNER_STARTED: integer = 34019;
  MCC_NOTIFY_BURNER_FINISHED_INTERNAL: integer = 34020;
  MCC_NOTIFY_BURNER_FINISHED: integer = 34021;
  MCC_NOTIFY_BURNER_FAILED_INTERNAL: integer = 34022;
  MCC_NOTIFY_BURNER_FAILED: integer = 34023;
  MCC_NOTIFY_BURNER_CLOSE_UI: integer = 34024;
  MCC_NOTIFY_BURNER_PREPARE_FOR_NEXT_COPY: integer = 34025;
  MCC_NOTIFY_RIP_STARTED: integer = 34026;
  MCC_NOTIFY_RIP_FINISHED: integer = 34027;
  MCC_NOTIFY_RIP_FAILED: integer = 34028;
  MCC_NOTIFY_RIP_PROGRESS_CHANGED: integer = 34029;
  MCC_NOTIFY_RIP_QUEUE_CHANGED: integer = 34030;
  MCC_NOTIFY_DVD_RIP_STARTED: integer = 34031;
  MCC_NOTIFY_DVD_RIP_FINISHED: integer = 34032;
  MCC_NOTIFY_DVD_RIP_FAILED: integer = 34033;
  MCC_NOTIFY_DVD_RIP_PROGRESS_CHANGED: integer = 34034;
  MCC_NOTIFY_DOWNLOAD_FINISHED: integer = 34035;
  MCC_NOTIFY_DOWNLOAD_FAILED: integer = 34036;
  MCC_NOTIFY_DOWNLOAD_STATUS_CHANGED: integer = 34037;
  MCC_NOTIFY_STATUS_CHECKER_COMPLETE: integer = 34038;
  MCC_NOTIFY_CURRENT_ZONE_CHANGED: integer = 34039;
  MCC_NOTIFY_DISPLAY_OWNER_CHANGED: integer = 34040;
  MCC_NOTIFY_AFTER_FIRST_UPDATE_LAYOUT_WINDOW: integer = 34041;
  MCC_NOTIFY_AFTER_FIRST_UPDATE_APPLY_VIEW_STATE: integer = 34042;
  MCC_NOTIFY_PROCESS_TIME_REMAINING: integer = 34043;
  MCC_NOTIFY_UI_UPDATE_ENABLE_DISABLE_STATES: integer = 34044;
  MCC_OBSOLETE_34045: integer = 34045;
  MCC_UPDATE_WINDOW_LAYOUT: integer = 34046;
  MCC_NOTIFY_SAVE_UI_BEFORE_SHUTDOWN: integer = 34047;
  MCC_OBSOLETE_34048: integer = 34048;
  MCC_NOTIFY_PLAYLIST_FILES_CHANGED: integer = 34049;
  MCC_NOTIFY_PLAYLIST_INFO_CHANGED: integer = 34050;
  MCC_NOTIFY_PLAYLIST_ADDED_INTERNAL: integer = 34051;
  MCC_NOTIFY_PLAYLIST_ADDED_BY_USER: integer = 34052;
  MCC_NOTIFY_PLAYLIST_REMOVED: integer = 34053;
  MCC_NOTIFY_PLAYLIST_COLLECTION_CHANGED: integer = 34054;
  MCC_NOTIFY_PLAYLIST_PROPERTIES_CHANGED: integer = 34055;
  MCC_NOTIFY_HANDHELD_UPLOAD_STARTED: integer = 34056;
  MCC_NOTIFY_HANDHELD_AFTER_DEVICE_CHANGED: integer = 34057;
  MCC_NOTIFY_HANDHELD_QUEUE_CHANGED: integer = 34058;
  MCC_NOTIFY_HANDHELD_INFO_COMPLETE: integer = 34059;
  MCC_NOTIFY_HANDHELD_AFTER_UPLOAD_FINISHED: integer = 34060;
  MCC_NOTIFY_COMPACT_MEMORY: integer = 34061;
  MCC_NOTIFY_SEARCH_CHANGED: integer = 34062;
  MCC_NOTIFY_SEARCH_CONTEXT_CHANGED: integer = 34063;
  MCC_NOTIFY_UPDATE_SHOPPING_CART: integer = 34064;
  MCC_NOTIFY_UPDATE_NAVIGATION_TRAIL: integer = 34065;
  MCC_NOTIFY_IMPORT_STARTED: integer = 34066;
  MCC_NOTIFY_IMPORT_FINISHED: integer = 34067;
  MCC_NOTIFY_ROTATED_IMAGES: integer = 34068;
  MCC_NOTIFY_LOGIN_STATE_CHANGE: integer = 34069;
  MCC_NOTIFY_MYGAL_PROGRESS: integer = 34070;
  MCC_NOTIFY_MYGAL_DONE: integer = 34071;
  MCC_NOTIFY_PODCAST_CHANGED: integer = 34072;
  MCC_NOTIFY_PODCAST_SETTINGS_CHANGED: integer = 34073;
  MCC_NOTIFY_CONVERT_PROGRESS: integer = 34074;
  MCC_NOTIFY_CONVERT_UPDATE: integer = 34075;
  MCC_NOTIFY_BREADCRUMBS_CHANGED: integer = 34076;
  MCC_OBSOLETE_34078: integer = 34077;
  MCC_NOTIFY_INSTALLED_PLUGINS_CHANGED: integer = 34078;
  MCC_NOTIFY_SUGGESTED_MUSIC_CHANGED: integer = 34079;
  MCC_NOTIFY_VIEW_SETTINGS_CHANGED: integer = 34080;
  MCC_NOTIFY_BEFORE_CONFIGURE_VIEW_SETTINGS: integer = 34081;
  MCC_NOTIFY_TV_RECORDING_CHANGED: integer = 34082;
  MCC_NOTIFY_TV_PROGRAMMING_GUIDE_CHANGED: integer = 34083;
  MCC_NOTIFY_TV_CHANNELS_CHANGED: integer = 34084;
  MCC_NOTIFY_TV_RECORDING_STARTED: integer = 34085;
  MCC_NOTIFY_TV_RECORDING_FINISHED: integer = 34086;
  MCC_NOTIFY_IMPORT_FILES_ADDED: integer = 34087;
  MCC_NOTIFY_PLAYBACK_OPTIONS_CHANGED: integer = 34088;
  MCC_NOTIFY_BEFORE_LAYOUT_USER_INTERFACE: integer = 34089;
  MCC_NOTIFY_AFTER_LAYOUT_USER_INTERFACE: integer = 34090;
  MCC_NOTIFY_ZONE_ADDED_OR_REMOVED: integer = 34091;
  MCC_NOTIFY_ZONE_LINKED_OR_UNLINKED: integer = 34092;
  MCC_NOTIFY_LIBRARY_LOCATIONS_CHANGED: integer = 34093;
  MCC_NOTIFY_DSP_SETTINGS_CHANGED_IN_CODE: integer = 34094;
  MCC_NOTIFY_OPTICAL_DISC_CHANGED: integer = 34095;
  MCC_STORE_DOWNLOAD: integer = 35000;
  MCC_STORE_PURCHASE: integer = 35001;
  MCC_STORE_SEARCH_AMAZON: integer = 35002;
  MCC_STORE_SEARCH_AMAZON_MP3_STORE: integer = 35003;
  MCC_STORE_TSHIRT: integer = 35004;

function Send_MC_COMMAND(MC_COMMAND: integer): longbool;

implementation

function Send_MC_COMMAND(MC_COMMAND: integer): longbool;
var
  NpWnd: HWnd;
begin
  NpWnd := FindWindow('MJFrame', nil);
  if NpWnd <> 0 then
  begin
    Result := PostMessage(NpWnd, WM_MC_COMMAND, MC_COMMAND, 0);
  end;

end;

end.
