{
  programs.rmpc = {
    enable = true;
    config = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          //address: "rupert.roto.lol:6600",
          address: "/tmp/mpd_socket",
          password: None,
          theme: Some("cat"),
          cache_dir: "~/.cache/rmpc",
          lyrics_dir: "/mnt/storage/music/root",
          //on_song_change: ["/home/leigh/.config/rmpc/notify.sh", "/home/leigh/.config/rmpc/increment_play_count"],
          volume_step: 5,
          max_fps: 120,
          scrolloff: 0,
          wrap_navigation: false,
          enable_mouse: true,
          enable_config_hot_reload: true,
          enable_lyrics_hot_reload: true,
          status_update_interval_ms: 1000,
          rewind_to_start_sec: None,
          keep_state_on_song_change: true,
          reflect_changes_to_playlist: false,
          select_current_song_on_change: false,
          ignore_leading_the: false,
          browser_song_sort: [Disc, Track, Artist, Title],
          directories_sort: SortFormat(group_by_type: true, reverse: false),

          album_art: (
              method: Auto,
              max_size_px: (width: 1200, height: 1200),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
          ),
          keybinds: (
              global: {
                  ":":       CommandMode,
                  ",":       VolumeDown,
                  "s":       Stop,
                  ".":       VolumeUp,
                  "<Tab>":   NextTab,
                  "<S-Tab>": PreviousTab,
                  "1":       SwitchToTab("Home"),
                  "2":       SwitchToTab("Directories"),
                  "3":       SwitchToTab("Playlists"),
                  "4":       SwitchToTab("Artists"),
                  "5":       SwitchToTab("Albums"),
                  "6":       SwitchToTab("Album Artists"),
                  "7":       SwitchToTab("Genre"),
                  "8":       SwitchToTab("Queue"),
                  "9":       SwitchToTab("Show"),
                  "0":       SwitchToTab("Search"),
                  "q":       Quit,
                  ">":       NextTrack,
                  "p":       TogglePause,
                  "<":       PreviousTrack,
                  "f":       SeekForward,
                  "z":       ToggleRepeat,
                  "x":       ToggleRandom,
                  "c":       ToggleConsume,
                  "v":       ToggleSingle,
                  "b":       SeekBack,
                  "~":       ShowHelp,
                  "u":       Update,
                  "U":       Rescan,
                  "I":       ShowCurrentSongInfo,
                  "O":       ShowOutputs,
                  "P":       ShowDecoders,
                  "R":       AddRandom,
              },
              navigation: {
                  "<PageUp>":    PageUp,
                  "<PageDown>":  PageDown,
                  "k":         Up,
                  "j":         Down,
                  "h":         Left,
                  "l":         Right,
                  "<Up>":      Up,
                  "<Down>":    Down,
                  "<Left>":    Left,
                  "<Right>":   Right,
                  "<C-k>":     PaneUp,
                  "<C-j>":     PaneDown,
                  "<C-h>":     PaneLeft,
                  "<C-l>":     PaneRight,
                  "<C-u>":     UpHalf,
                  "N":         PreviousResult,
                  "a":         Add,
                  "A":         AddAll,
                  "r":         Rename,
      //            "<C-R>": Rating(kind: Value(5)),
                  "n":         NextResult,
                  "g":         Top,
                  "<Space>":   Select,
                  "<C-Space>": InvertSelection,
                  "G":         Bottom,
                  "<CR>":      Confirm,
                  "i":         FocusInput,
                  "J":         MoveDown,
                  "<C-d>":     DownHalf,
                  "/":         EnterSearch,
                  "<C-c>":     Close,
                  "<Esc>":     Close,
                  "K":         MoveUp,
                  "D":         Delete,
                  "B":         ShowInfo,
                  "<C-z>":     ContextMenu(),
                  "<C-s>":     Save(kind: Modal(all: false, duplicates_strategy: Ask)),
              },
              queue: {
                  "D":       DeleteAll,
                  "<CR>":    Play,
                  "a":       AddToPlaylist,
                  "d":       Delete,
                  "C":       JumpToCurrent,
                  "X":       Shuffle,
              },
          ),
          search: (
              case_sensitive: false,
              ignore_diacritics: true,
              search_button: false,
              mode: Contains,
              tags: [
                  (value: "any",         label: "Any Tag"),
                  (value: "artist",      label: "Artist"),
                  (value: "album",       label: "Album"),
                  (value: "albumartist", label: "Album Artist"),
                  (value: "title",       label: "Title"),
                  (value: "filename",    label: "Filename"),
                  (value: "genre",       label: "Genre"),
              ],
          ),
          artists: (
              album_display_mode: SplitByDate,
              album_sort_by: Date,
              album_date_tags: [Date],
          ),
          tabs: [
              (name: "Home", pane: Split(direction: Horizontal, panes: [
                          (size: "70%", borders: "NONE", pane: Split(direction: Vertical,panes: [
                                      (size: "100%", borders: "NONE", pane: Pane(Queue)),
                                  ])
                          ),
                          (size: "30%", borders: "NONE", pane: Split(direction: Vertical, panes: [
                                      (size: "0.45r", borders: "NONE", pane: Pane(AlbumArt)),
                                      (size: "100%", borders: "NONE", pane: Pane(Lyrics)),
                                  ])
                          ),
                      ])
              ),
              (name: "Directories", pane: Split(direction: Horizontal,panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Directories)),
                      ])
              ),
              (name: "Playlists", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Playlists)),
                      ])
              ),
              (name: "Artists", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Artists)),
                      ])
              ),
              (name: "Albums", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Albums)),
                      ])
              ),
              (name: "Album Artists", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(AlbumArtists)),
                      ])
              ),
              (name: "Genre", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Browser(root_tag: "genre", separator: ";"))),
                      ])
              ),
              (name: "Queue", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Queue))
                      ])
              ),
              (name: "Show",pane: Split(direction: Vertical, panes: [
                          (size: "75%", pane: Split(direction: Horizontal, panes: [
                                      (size: "25%", borders: "NONE", pane: Pane(Queue)),
                                      (size: "50%", borders: "NONE", pane: Pane(Lyrics)),
                                      (size: "25%", borders: "NONE", pane: Pane(AlbumArt)),
                                  ])
                          ),
                          (size: "25%", borders: "NONE", pane: Pane(Cava)),
                      ])
              ),
              (name: "Search", pane: Split(direction: Horizontal, panes: [
                          (size: "100%", borders: "ALL", pane: Pane(Search)),
                      ])
              ),
          ],
          cava: (
              framerate: 60, // default 60
              autosens: true, // default true
              sensitivity: 100, // default 100
              lower_cutoff_freq: 50, // not passed to cava if not provided
              higher_cutoff_freq: 10000, // not passed to cava if not provided
              input: (
                  method: Fifo,
                  source: "/tmp/mpd.fifo",
                  sample_rate: 44100,
                  channels: 2,
                  sample_bits: 24,
              ),
              smoothing: (
                  noise_reduction: 77, // default 77
                  monstercat: false, // default false
                  waves: false, // default false
              ),
              // this is a list of floating point numbers thats directly passed to cava
              // they are passed in order that they are defined
              eq: []
          ),
      )
    '';
  };
}
