; -*- mode: clojure -*-

(info "loading" (clojure.string/join "/" [*config-file* "100-core.clj"]))

;; start servers
(tcp-server)
(udp-server)
(ws-server)

; Expire old events from the index every 5 seconds.
(periodically-expire 5)

(let [index (index)]
    ; Inbound events will be passed to these streams:
    (streams
        ; Index all events immediately.
        index

        ; Calculate an overall rate of events.
        (with {:metric 1
               :host nil
               :state "ok"
               :service "events/sec"}
            (rate 5 index)
        )

        ; Log expired events.
        (expired  #(warn "expired" %))
    )
)

