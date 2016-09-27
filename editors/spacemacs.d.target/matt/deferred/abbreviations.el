(define-abbrev-table 'global-abbrev-table
  '(
    ("ipyimp"
     "%matplotlib inline
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# use seaborn plotting defaults
import seaborn as sns; sns.set()

pd.options.display.width = 300
" nil 0)
    ("pry" "require 'pry'; binding.pry ; true; " nil 0)
    ("ftr" ", focus: true" nil 0)
    ("saveand" "save_and_open_page" nil 0)
    ("ipd" "from ipdb import set_trace; set_trace()  # NOQA" nil 0)
    ))
(setq save-abbrevs nil)
(setq-default abbrev-mode t)
