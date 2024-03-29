;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services dotfiles)
             (gnu home services messaging)
             (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages
            (list
             "alacritty"
             "arandr"
             "autorandr"
             "bind:utils"
             "emacs"
             "git"
             "openssl"
             "sbcl"
             "scrot"
             "ungoogled-chromium"
             "xournalpp"
             "xscreensaver"
             "xterm")))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-fish-service-type)
        (service home-redshift-service-type)
        (service home-dbus-service-type)
        (service home-unclutter-service-type)
        (service home-xmodmap-service-type
                 (home-xmodmap-configuration
                  (key-map '(("remove Lock" . "Caps_Lock")))))
        (service home-dotfiles-service-type
                 (home-dotfiles-configuration
                  (source-directory "/home/dissoc/Workspace/dissoc-dotfiles/")
                  (directories (list "guix" "stumpwm"))))
        (simple-service 'extra-env-vars
                        home-environment-variables-service-type
                        `(("EDITOR" . "emacs")
                          ("VISUAL" . "emacs")))
        ;; znc service will fail to start without a config
        ;; run 'znc --makeconfig' to generate a config file
        (service home-znc-service-type))))
