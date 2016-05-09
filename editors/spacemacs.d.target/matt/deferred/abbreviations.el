(define-abbrev-table 'global-abbrev-table
  '(
    ("pry" "require 'pry'; binding.pry ;" nil 0)
    ("ftr" ", focus: true" nil 0)
    ("save_and" "save_and_open_page" nil 0)
    ("ipdb" "from ipdb import set_trace; set_trace()" nil 0)
    ))
(setq save-abbrevs nil)
(setq-default abbrev-mode t)
