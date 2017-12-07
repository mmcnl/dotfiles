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
    ("pryy" "binding.pry" nil 0)
    ("pryr" "require 'pry'; binding.pry" nil 0)
    ("ipd" "from ipdb import set_trace; set_trace()  # NOQA" nil 0)
    ))
(setq save-abbrevs nil)
(setq-default abbrev-mode t)
