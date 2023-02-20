(defun products ()
  (mapcar
   (lambda (item) (make-instance 'Daemon
                                 :name (car item)

                                 :description (if (listp (cdr item))
                                                  (cdr (assoc :description (cdr item)))
                                                  (cdr item))

                                 :approx-marginal-cost
                                 (if (listp (cdr item))
                                     (cdr (assoc :approx-marginal-cost
                                                 (cdr item)))
                                     nil)))
   '((sherlock .
      ((:description .
        "Hardware looks like a game controller with a pocket daemon installed")
       (:approx-marginal-cost . 20)))
     (pocket-daemon .
      ((:description "Handheld daemon gadget terminal composed of an RPi, small touch screen, and lots of USB goodies. Tight Tactical Gear for dense urban environments")
       (:approx-marginal-cost . 100)))
     (cybook .
      "A digital book experience ran on a PiZero. To be enjoyed with real book and beer.")
     (chiron .
      "A friend and tutor for Zeus")
     (daemon-head .
      "A medium physical head and neck for a daemon. Fits RPi Daemons.")
     (wray .
      "Platform robot meant for deploying smaller machines")
     (onix-battlestation .
      "A colleague daemon battlestation meant for heavy workloads.")
     (onix-code-analyst .
      "A keeper and analyzer of open source code repos")
     (saphira .
      "A versatile daemon interested in organic structures, progress, companionship, and high octane yet safe activities.")
     (saphira-camp .
      "A high tech mobile campsite")
     (shelfie .
      "A daemon with robotic arm for book shelf item manipulation. This seems like a great item for beginners (like myself, lol)")
     (gia .
      "Robot that takes care of plants")
     (rod-of-sight-and-signal .
      "Intelligent signal generator for a modern age. Imagine the tails of the Navi, but in a staff, lol")
     (holonic .
      "3d representation space of holons, delivered via Steam")
     (luxium .
      "Pixar lamp clone. Might make a great YouTube video")
     (steel-raven .
      "A supercharged rubber ducky w/ RPi zero. Train steel-raven to hack")
     (microdaemon .
      "A RPi Zero powered daemon robot that drives fast as fuck. Seems fun, if it were mouse sized")
     (daemon-10 .
      "10th daemon described in the black moleskine notebook from NYC")
     (kuberdog-sentinel .
      "Primary daemon wearable for dogs, made from a harness")
     (cypack .
      "Cybernetic backpack with a really terrible name")
     (helm .
      "HUD for cyborgs. ++ for prior art")
     (kuberdog-console .
      "holonic + pocket-daemon + sherlock for dogs")
     (plastois .
      "A 3d printer. 9/10 on the name")
     (onix .
      "An AI creative")
     (onix-bot .
      "A robotic body for onix")
     (giactory .
      "Daemon for farm. To live on Colorado property 8/10 on idea and purpose")
     (shot-sentry .
      "A medium/long range camera set to fully auto. Streams and analyzes video data with long uptimes")
     (hyperdriver .
      "A cyber-glove input system for hypernerds. 6/10 on name, but 9/10 on the idea. This needs to be created")
     (holon-lisp .
      "A lisp compiler and dialect for VelOs")
     (VelOs .
      "A small and speedy Common Lisp OS for Cyborgs. I think I will stick with the VelOs name.")
     (Sudo .
      "A light humanoid robot. Will compete for shits and gigs with whatever the fuck Tesla is overengineering"))))

(defun print-all-products ()
  (mapcar #'print-daemon (products)))
