module UndoQuickFix.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

clone :: [Step]
clone =
  [STEP {n=1, r="IUR04"
        ,c="Confirm a developer is able to download a remote repository."
        ,x="No error."
        ,p="git", a=["clone", repoURL], f=[]
        }
  ]

undoQuickFix :: [Step]
undoQuickFix =
  [STEP {n=2, r="IUR04"
        ,c="Confirm a developer is able refresh their local repository after a remote repository has been downloaded."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=3, r="IUR06"
        ,c="Confirm a developer is able to create a new branch to work on a programming assignment."
        ,x="No error."
        ,p="git", a=["checkout", "-b", "quick-fix"], f=[]
        }
  ,STEP {n=4, r="IUR07"
        ,c="Confirm a developer is able to establish branch tracking between the local and remote branches."
        ,x="No error."
        ,p="git", a=["branch", "-u", "origin/quick-fix", "quick-fix"], f=[]
        }
  ,STEP {n=5, r="IUR07"
        ,c="Confirm a developer is able to list all branches."
        ,x="No error."
        ,p="git", a=["branch", "-a"], f=[]
        }
  ,STEP {n=6, r="IUR07"
        ,c="Confirm a developer is able to list the status of their local repository."
        ,x="No error."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=7, r="IUR03"
        ,c="Confirm a developer is able to refresh the new branch in their local repository."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=8, r="IUR03"
        ,c="Confirm a developer is able to make a software change."
        ,x="No error."
        ,p="sed", a=["-i.bak", "-e", "s/\\[Z\\]/\\[a\\]/g" ,"QuickSort.hs"], f=[]
        }
  ,STEP {n=9, r="IUR07"
        ,c="Confirm a developer is able to remove files that are not being tracked by the local repository."
        ,x="Untracked files are removed."
        ,p="git", a=["clean", "-f"], f=[]
        }
  ,STEP {n=10, r="IUR03"
        ,c="Confirm a developer is able to add changed files to the local repository."
        ,x="No error."
        ,p="git", a=["add", "."], f=[]
        }
  ,STEP {n=11, r="IUR07"
        ,c="Confirm a developer is able to determine thier change has been added to the local repository."
        ,x="File changes are being tracked by local repository."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=12, r="IUR05"
        ,c="Confirm a developer is able to commit change to the the local repository."
        ,x="No error."
        ,p="git", a=["commit", "-m", "Change All [Z] to [a]"], f=[]
        }
  ,STEP {n=13, r="IUR08"
        ,c="Confirm a developer is able to update a remote Git repository based on changes made to the local repository."
        ,x="No error."
        ,p="git", a=["push"], f=[]
        }
  ,STEP {n=14, r="IUR09"
        ,c="Confirm a developer is able to review the differences between their master branch and quick-fix branch."
        ,x="Differences are displayed."
        ,p="git", a=["diff", "master..quick-fix"], f=[]
        }
  ,STEP {n=15, r="IUR07"
        ,c="Confirm a developer is able to determine their new branch is tracked independently of the master branch."
        ,x="Branch tracking is displayed."
        ,p="git", a=["branch", "-vv"], f=[]
        }
  ,STEP {n=16, r="IUR07"
        ,c="Confirm a developer is able to review a list of changes made to their repository."
        ,x="Commits are displayed."
        ,p="git", a=["log", "--oneline", "-3"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
    ensureDirectoryExists CLEAN undoQuickFixPath
    ensureDirectoryExists CLEAN package2Path
    withDirectory package2Path $
        runRecipe clone undoQuickFixPath WriteMode
    withDirectory quicksort2Path $
        runRecipe undoQuickFix undoQuickFixPath AppendMode
