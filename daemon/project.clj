(defproject daemon "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :injections [(clojure.lang.RT/loadLibrary org.opencv.core.Core/NATIVE_LIBRARY_NAME)]
  :dependencies [[org.clojure/clojure "1.9.0-alpha10"]
                 [alembic "0.3.2"]
                 [quil "2.4.0"]
                 [overtone/at-at "1.2.0"]
                 [org.clojure/core.async "0.2.385"]
                 [opencv/opencv "3.1.0"] ; added line
                 [opencv/opencv-native "3.1.0"]
                 [opencv/opencv-imgshow "1.0.1"]
                 [clj-time "0.12.0"]
                 [google-apps-clj "0.5.2"]
                 [org.clojure/data.json "0.2.6"]
                 [http-kit "2.2.0"]
                 [com.ibm.watson.developer_cloud/java-sdk "3.3.1"]
                 [org.twitter4j/twitter4j-core "[4.0,)"]
                 [org.twitter4j/twitter4j-stream "[4.0,)"]
                 [com.1stleg/jnativehook "2.0.2"]
                 [org.apache.commons/commons-io "1.3.2"]
                 [incanter "1.5.7"]
                 [org.clojure/math.numeric-tower "0.0.4"]
                 [korma "0.4.3"]
                 [org.postgresql/postgresql "9.4.1208"]]
  :repositories {"sonatype-oss-public" "https://oss.sonatype.org/content/groups/public/"}
  :plugins [[lein-ns-dep-graph "0.1.0-SNAPSHOT"]
            [cider/cider-nrepl "0.13.0"]]
  :jvm-opts ^:replace []
  :main daemon.core)



















