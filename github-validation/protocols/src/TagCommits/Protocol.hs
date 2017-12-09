module TagCommits.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

-- | Return a git-log pretty format string.
logPretty :: [String]
logPretty = ["log", "--graph", "--pretty=format:'%h (%cr) <%cn> %d'"]

-- | Return a string to limit log output to nbr lines
shortLog :: Integer -> [String]
shortLog nbr = logPretty ++ [(show $ nbr * (-1))]

-- | Return a string to simplify commits with a branch or tag.
simplifyDec :: [String]
simplifyDec = logPretty ++ ["--simplify-by-decoration"]

-- | Return a list of Step to demonstrate Git-tagging workds.
tagCommits :: [Step]
tagCommits =
  [STEP {n=1, r="IUR10"
        ,c="Confirm pre-existing tags are present."
        ,x="Pre-existing tags are listed without error."
        ,p="git", a=["tag"], f=[]
        }
  ,STEP {n=2, r="IUR10"
        ,c="Confirm pre-existing git-commits are present."
        ,x="Git-commit history is shown without error."
        ,p="git", a=(simplifyDec), f=[]
        }
  ,STEP {n=3, r="IUR10"
        ,c="Confirm new branch b2.0 is created from tag v2.0."
        ,x="Switch to a new branch 'b2.0' is displayed."
        ,p="git", a=["checkout", "-b", "b2.0", "v2.0"], f=[]
        }
  ,STEP {n=4, r="IUR10"
        ,c="Confirm (HEAD, tag: v2.0, b2.0) is displayed for first git-commit."
        ,x="Git-commit history shows (HEAD, tag: v2.0, b2.0) at first commit."
        ,p="git", a=(shortLog 2), f=[]
        }
  ,STEP {n=5, r="IUR10"
        ,c="Confirm new branch b1.1 is created from tag v1.1."
        ,x="Switch to a new branch 'b1.1' is displayed."
        ,p="git", a=["checkout", "-b", "b1.1", "v1.1"], f=[]
        }
  ,STEP {n=6, r="IUR10"
        ,c="Confirm (HEAD, tag: v1.1, b1.1) is displayed for first git-commit."
        ,x="Git-commit history shows (HEAD, tag: v1.1, b1.1) at first commit."
        ,p="git", a=(shortLog 2), f=[]
        }
  ,STEP {n=7, r="IUR10"
        ,c="Confirm branches b1.1, b2.0 and master exist."
        ,x="Branches b1.1, b2.0 and master are listed.  More branches is okay."
        ,p="git", a=["branch", "-v"], f=[]
        }
  ,STEP {n=8, r="IUR10"
        ,c="Confirm switch to master branch."
        ,x="Switch to branch 'master' is displayed."
        ,p="git", a=["checkout", "master"], f=[]
        }
  ,STEP {n=9, r="IUR10"
        ,c="Confirm master branch is not tagged with v3.0."
        ,x="At minimum, '(HEAD, origin/master, origin/HEAD, master)' is displayed for first commit."
        ,p="git", a=(shortLog 2), f=[]
        }
  ,STEP {n=10, r="IUR10"
        ,c="Add tag 'v3.0' is added to HEAD."
        ,x="No error."
        ,p="git", a=["tag", "v3.0"], f=[]
        }
  ,STEP {n=11, r="IUR10"
        ,c="Confirm tag 'v3.0' is added to HEAD."
        ,x="At minimum, '(HEAD, tag: v3.0, origin/master, origin/HEAD, master)' is displayed for first commit."
        ,p="git", a=(shortLog 2), f=[]
        }
  ,STEP {n=12, r="IUR10"
        ,c="Confirm tag 'v3.0' is deleted."
        ,x="No error."
        ,p="git", a=["tag", "-d", "v3.0"], f=[]
        }
  ,STEP {n=13, r="IUR10"
        ,c="Confirm branch 'b1.1' is deleted."
        ,x="No error."
        ,p="git", a=["branch", "-d", "b1.1"], f=[]
        }
  ,STEP {n=14, r="IUR10"
        ,c="Confirm branch 'b2.0' is deleted."
        ,x="No error."
        ,p="git", a=["branch", "-d", "b2.0"], f=[]
        }
  ,STEP {n=15, r="IUR10"
        ,c="Confirm master branch remains."
        ,x="No error."
        ,p="git", a=["branch", "-v"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN tagCommitsPath
  withDirectory repo1Path $
       runRecipe tagCommits tagCommitsPath WriteMode
