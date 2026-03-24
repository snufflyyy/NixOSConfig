{ config, pkgs, ... }:

{
  home.username = "braden";
  home.homeDirectory = "/home/braden";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      nrt = "sudo nixos-rebuild test";
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk3.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3; 
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.theme = config.gtk.theme;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "hyprpaper"
      ];

      monitor = [
        "DP-2, 2560x1440@240, 0x0, 1.25"
        "HDMI-A-1, 1920x1080@240, -1920x0, 1.0"
      ];

      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$app-launcher" = "rofi -show drun";
      "$web-browser" = "zen";      
      "$file-manager" = "nautilus";
      "$music-player" = "spotify";
      "$discord" = "discord";

      general = {
        layout = "dwindle";

        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;

        "col.active_border" = "rgba(afafafaa)";
        "col.inactive_border" = "rgba(353535aa)";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      }; 

      decoration = {
        rounding = 10;
        rounding_power = 2;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };

        shadow = {
          enabled = true;

          range = 15;
          render_power = 3;

          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

        animation = [
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
      };

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      bind = [
        "$mod, T, exec, $terminal"
        "$mod, SPACE, exec, $app-launcher"
        "$mod, F, exec, $web-browser"
        "$mod, E, exec, $file-manager"
        "$mod, D, exec, $discord"
        "$mod, S, exec, $music-player"
        "$mod, Q, killactive"

        "$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
      
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/Wallpapers/nighthawks.jpg"
      ];
      wallpaper = [
        ",~/Pictures/Wallpapers/nighthawks.jpg"
      ];
    };
  };

  programs.rofi = {
    enable = true;
    theme = "/etc/nixos/rofi/theme.rasi";
    extraConfig = {
      show-icons = true;
    };
  };

  home.packages = with pkgs; [
    neovim

    clang
    cmake    

    adwaita-icon-theme
    nerd-fonts.jetbrains-mono

    ghostty
    rofi
    loupe
    gnome-font-viewer
    celluloid
  
    mullvad-vpn
    zed-editor 
    discord
    spotify
    jellyfin-desktop
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
