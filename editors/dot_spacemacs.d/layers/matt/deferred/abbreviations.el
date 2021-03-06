(define-abbrev-table 'global-abbrev-table
  '(
    ("exto"
     "expect_tabular_output(<<TEXT

TEXT
  ) do
     end
" nil 0)
    ("ipyimp"
     "%matplotlib inline
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# use seaborn plotting defaults
import seaborn as sns; sns.set()

pd.options.display.width = 300
" nil 0)

    ("html5" "<!DOCTYPE HTML>
<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <title>title</title>
  </head>
  <body>
  </body>
</html>
" nil 0)

    ("pryy" "require 'pry'; binding.pry" nil 0)
    ("ipdd" "from ipdb import set_trace; set_trace()  # NOQA" nil 0)
    ("pdbb" "from pdb import set_trace; set_trace()  # NOQA" nil 0)
    ))
(setq save-abbrevs nil)
(setq-default abbrev-mode t)
