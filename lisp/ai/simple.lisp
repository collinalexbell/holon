(in-package :holon)
;36 A SIMPLE LISP PROGRAM
(defun one-of ( set )
  "Pick one element of set , and make alist of i t . "
  (list (random-elt set ) ) )
(defun random-elt (choices)
  "Choose an element from alist at random."
  ( elt choices (random (length choices ))))
(defun sentence () (append (noun-phrase) ( verb-phrase ) ) )
(defun noun-phrase () (append (  Article ) (Noun)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun  Article () (one-of ' (  the a ) ) )
(defun Noun () (one-of *hacker-nouns* ) )
(defun Verb () (one-of *hacker-verbs* ) )



(defparameter *hacker-glossary*


'((nouns . ("/dev/null" "1TBS" "404" "@-party" "abbrev" "ABEND" "Acme" "ad-hockery" "address harvester" "admin" "ADVENTFigure�1.�Screen shot of the original ADVENT game" "adware" "AFAIK" "AFJ" "AI" "airplane rule" "Alderson loop" "aliasing bug" "Alice and Bob" "alpha geek" "alpha particles" "Aluminum Book" "Amiga" "Amiga Persecution Complex" "amper" "Angband" "angle brackets" "angry fruit salad" "annoybot" "annoyware" "anti-idiotarianism" "AOL!" "app" "arenamalloc: corrupt   arena" "arg" "ARMM" "armor-plated" "asbestos cork award" "asbestos longjohns" "ASCII" "ASCII art" "ASCIIbetical order" "astroturfing" "attoparsec" "Aunt Tillie" "autobogotiphobia" "avatar" "B1FF" "back door" "backbone cabal" "backbone site" "background" "backreference" "backronym" "backward combatability" "Bad Thing" "balloonian variable" "banana problem" "bandwidth" "bang path" "bannerbanner({1,6" "banner ad" "banner site" "bar" "bare metal" "barf" "barfmail" "barn" "barney" "BASIC" "batbelt" "bathtub curve" "Batman factor" "bazaar" "bboard" "BBS" "BCPL" "beanie key" "beep" "Befunge" "beige toaster" "bells and whistles" "bells whistles and gongs" "benchmark" "Berzerkeley" "beta" "BFI" "bible" "BiCapitalization" "big iron" "Big Red Switch" "Big Room" "big win" "bignum" "bigot" "binary four" "bit" "bit bang" "bit bashing" "bit bucket" "bit decay" "bit rot" "bit twiddling" "bit-paired keyboard" "bitblt" "bitty box" "bixie" "black art" "black hole" "black magic" "blargh" "blastUnable to kill all   processes.  Blast them (y/n)?" "blat" "blinkenlights" "blitter" "blivet" "bloatware" "blog" "Bloggs Family" "BLT" "Blue Glue" "blue goo" "Blue Screen of Death" "blue wire" "blurgle" "BNF*+[]" "boa" "board" "boat anchor" "bob" "BOF" "BOFH" "bogo-sort" "bogometer" "BogoMIPS" "bogon" "bogon filter" "bogon flux" "bogosity" "Bohr bug" "bondage-and-discipline language" "boot" "Borg" "bot" "bottom feeder" "bottom-up implementation" "bounce message" "boustrophedon" "box" "boxed comments" "boxology" "brain dump" "brain fartdir" "braino" "brainwidth" "bread crumbs" "break-even point" "breath-of-life packet" "breedle" "brick" "broadcast storm" "broken arrow" "BrokenWindows" "broket" "brown-paper-bag bug" "browser" "BRS" "brute force and ignorance" "BSD" "BUAF" "BUAG" "bubble sort" "bucky bits" "buffer chuck" "buffer overflow" "bug" "bug-for-bug compatible" "bug-of-the-month club" "bullschildt" "buried treasure" "burn-in period" "burst page" "BWQ" "byte" "byte sex" "C" "C Programmer's Disease" "C++" "calculator" "Camel Book" "candygrammar" "careware" "cargo cult programming" "cascade" "case and pastecase" "casters-up mode" "casting the runes" "cathedral" "chad" "chad box" "channel#initgame#hottubcallahans#report#report" "channel hopping" "channel op" "chanop" "char" "charityware" "chawmp" "check" "chemist" "Chernobyl chicken" "Chernobyl packet" "chicken head" "chickenboner" "chiclet keyboard" "Chinese Army technique" "choad" "chomper" "CHOP" "Christmas tree" "Christmas tree packet" "chrome" "Church of the SubGenius" "CI$" "Cinderella Book" "Classic C" "click of death" "CLM" "clock" "clocks" "clone-and-hack coding" "clover key" "clustergeeking" "co-lo" "coaster" "COBOL" "COBOL fingers" "cobweb site" "code grinder" "code monkey" "Code of the Geeks" "code police" "codes" "codewalkervgrind" "coefficient of X" "cokebottle" "cold boot" "COME FROMCOME FROMCOME   FROMCOME FROMCOME FROMDOCOME FROMCONTINUECONTINUECOME FROMAT 100COME FROM 100ALTERCOME FROM" "comm mode" "command key" "Commonwealth Hackisheekookfrodobilbowobblewubbleflobbananatomdickharrywombatfrog" "compiler jock" "compo" "Compu$erve" "computer confetti" "computron" "con" "confuser" "connector conspiracy" "console" "console jockey" "cookbook" "cooked mode" "cookie" "cookie file" "cookie jar" "cookie monster" "copious free time" "copper" "copy protection" "copycenter" "copyleft" "copyparty" "core" "core cancer" "core dump" "core leak" "Core Wars" "cosmic rays" "cow orker" "cowboy" "CP/M" "CPU Wars" "cracker" "cracking" "crapplet" "CrApTeX" "crash and burn" "crawling horror" "creationism" "creeping elegance" "creeping featurism" "creeping featuritis" "cretin" "crippleware" "critical mass" "crlf" "crock" "crossload" "crudware" "cruftsmanship" "crumb" "cryppie" "CTSS" "cube" "cup holder" "cursor dipped in X" "cybercrud" "cyberpunk" "cyberspace" "cycle of reincarnation" "cycle server" "cypherpunk" "C|N>K" "daemon" "daemon book" "dahmum" "dancing frog" "dangling pointer" "dark-side hacker" "Datamation" "DAU" "Dave the Resurrector" "day mode" "DDTadbsdbdbxgdb" "dead beef attack" "dead code" "DEADBEEF" "deadlock" "deadly embrace" "death code" "Death Square" "Death Star" "DEC Wars" "decay" "deckle" "DED" "deep hack mode" "deep magic" "deep space" "defenestration" "deletia" "deliminator" "demigod" "demo mode" "demoeffect" "demogroup" "demon" "demon dialer" "demoparty" "depeditate" "dickless workstation" "dictionary flame" "Dilbert" "ding" "dinosaur" "dinosaur pen" "dinosaurs mating" "dirtball" "dirty power" "disclaimer" "Discordianism" "disk farm" "display hack" "distribution" "distro" "doc" "documentation" "dogcow" "dogfood" "dongle" "dongle-disk" "doorstop" "dot file" "doubled sig" "DP" "DPer" "Dr. Fred Mbogo" "dragon" "Dragon Book" "dread high-bit disease" "dread questionmark disease" "DRECNET" "driver" "droid" "drone" "drool-proof paper" "drop-ins" "drop-outs" "drum" "drunk mouse syndrome" "DSW" "Duff's device++*to" "dumb terminal" "dumbass attackrm -r *mkfs" "dump" "dumpster diving" "dusty deck" "dynner" "Easter eggmake lovenot war?" "Easter egging" "EBCDIC" "ECP" "ed" "egg" "eighty-column mind" "El Camino Bignum" "elder days" "elevator controller" "ELIZA effect" "elvish" "EMACS" "emoticon" "empire" "engine" "enhancement" "EOD" "EOF" "EOL" "EOU" "epoch" "epsilon squared" "era" "Eric Conspiracy" "Eris" "error 33" "Evil Empire" "examining the entrails" "excl" "EXE" "exec" "Exploder" "exploit" "external memory" "eye candy" "eyeball search" "face time" "factor" "fairings" "fan" "fandango on core" "FAQ" "FAQ list" "FAQL" "farm" "fat electrons" "fear and loathing" "featureformat" "feature creature" "feature creep" "feature key" "feature shock" "featurectomy" "feeper" "feeping creature" "feeping creaturism" "fence" "fencepost error" "FidoNet" "field circus" "field servoid" "file signature" "filk" "filter" "Finagle's Law" "finger trouble" "finger-pointing syndrome" "firefighting" "firehose syndrome" "firewall code" "firewall machine" "fireworks mode" "firmware" "fish" "FISH queue" "fisking" "fix" "flag" "flag day" "flamage" "flame bait" "flame war" "flamer" "flarp" "flavor" "flippy" "flowchart" "flower key" "flypage" "Flyspeck 3" "flytrap" "FM" "fnord" "FOAF" "followup" "fontology" "foobar" "fool" "fool file" "Foonly" "footprint" "fork bombmain()   {for(;;)fork();$0 & $0   &" "Formosa's Law" "Fortrash" "fortune cookie" "forum" "fossil" "four-color glossies" "frag" "Frankenputer" "fred" "Fred Foobar" "frednet" "free software" "freeware" "friode" "fritterware" "front end" "frotz" "frowney" "FRS" "FUBAR" "FUD" "FUD wars" "fudge factor" "Full Monty" "fum" "functino" "funny money" "gang bang" "Gang of Four" "garply" "gawble" "GCOSpw_gecos" "GECOS" "geek" "geek code" "gen" "gender mender" "General Public Virus" "Genius From Mars Technique" "gig" "gilley" "gillion" "ginger" "GIPS" "GIYF" "glass" "glass tty" "glassfet" "globglob" "glue" "gnubie" "GNUMACS" "go-faster stripes" "Godzillagram" "gonk" "gonkulator" "Good Thing" "google juice" "gopher" "gopher hole" "gorets" "gorilla arm" "gorp" "GOSMACS" "gotchaif (a=b)   {code;bacodeaif   (a==b) {code;codeab" "GPL" "GPV" "gray goo" "Great Renaming" "Great Runes" "Great Worm" "great-wall" "green bytes" "green card" "green lightning" "green machine" "greenbar" "gribble" "grilf" "grind crank" "grue" "grunge" "gubbish" "guiltware" "gunpowder chicken" "guru" "guru meditation" "GWF" "hack attack" "hack mode" "hack value" "hacker" "hacker ethic" "Hackers (the movie)" "hacking run" "Hacking X for Y" "Hackintosh" "hackishness" "hackitude" "hair" "hairball" "HAKMEM" "hakspek" "Halloween Documents" "hamster" "handle" "handshaking" "hard boot" "hash bucket" "hash collision" "hat" "HCF" "heartbeat" "heatseeker" "heavy metal" "heavy wizardry" "heisenbug" "hex" "hexadecimal" "hexit" "hidden flag" "high bit" "high moby" "hing" "hired gun" "HLL" "hoarding") ) (verbs . ("adger" "amp off" "background" "baggy pantsing" "bang on" "beam" "beep" "biffbiff" "black hole" "blammo" "blastUnable to kill all   processes.  Blast them (y/n)?" "blit" "blow an EPROM" "blow away" "blow past" "BLT" "bogotify" "bomb" "boot" "bottom-post" "bounce" "bring X to its knees" "bumpforwhiledo-while" "burble" "burn a CD" "catcat" "cdr" "choke#define" "clobber" "comment out" "compress" "condition out#if 0#ifdef   notdef#endif" "cough and die" "crack root" "crank" "creep" "crossload" "dddd" "dehose" "despew" "die" "die horribly" "dike" "disemvowel" "dispress" "dogpile" "download" "drain" "drop on the floor" "EXCH" "eyeball search" "fall throughcasebreakGREENREDPINKPINK" "faradize" "fat-finger" "filk" "finn" "fix" "flap" "flatten" "flood" "flush" "FOD" "fold case" "foreground" "frag" "freeze" "frink" "frobnicate" "frogging" "gen" "generate" "glark" "globglob" "go flatline" "go gold" "gobble" "google" "grokvoid" "gronk" "gunch" "hack on" "hack together" "hack up" "hammer" "hand cruft" "hand-roll" "hang") ))  )

(defparameter *hacker-nouns* (cdr (assoc 'nouns *hacker-glossary*)))
(defparameter *hacker-verbs* (cdr (assoc 'verbs *hacker-glossary*)))
