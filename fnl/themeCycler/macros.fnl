(local m {})

(fn m.import [...]
  (icollect [_ name (ipairs [...])]
    `(local ,name (require ,(tostring name)))))

(fn m.def [name v]
  `(local ,name ,v))

(fn m.merge-right [left-tbl right-tbl]
  `(vim.tbl_deep_extend :force ,left-tbl ,right-tbl))

(fn m.import-from [kv mod]
  (icollect [_ name (ipairs kv)]
    `(local ,name (. (require ,(tostring mod)) ,(tostring name)))))

m
