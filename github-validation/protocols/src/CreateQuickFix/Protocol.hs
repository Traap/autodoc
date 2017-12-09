module CreateQuickFix.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

createQuickFix :: [Step]
createQuickFix =
  [STEP {n=1, r="IUR04"
        ,c="Confirm a developer is able to download a remote repository."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=2, r="IUR06"
        ,c="Confirm a developer is able to create a new branch."
        ,x="No error."
        ,p="git", a=["checkout", "-b", "quick-fix"], f=[]
        }
  ,STEP {n=3, r="IUR06"
        ,c="Confirm a developer is able to obtain a listing of all branches."
        ,x="New branch quick-fix is listed."
        ,p="git", a=["branch", "-a"], f=[]
        }
  ,STEP {n=4, r="IUR02"
        ,c="Confirm a developer is able to make a code change."
        ,x="No error."
        ,p="sed", a=["-i.bak", "-e", "s/\\[a\\]/\\[Z\\]/g" ,"QuickSort.hs"], f=[]
        }
  ,STEP {n=5, r="IUR07"
        ,c="Confirm a developer is able to remove untracked files."
        ,x="Untracked files are removed."
        ,p="git", a=["clean", "-f"], f=[]
        }
  ,STEP {n=6, r="IUR03"
        ,c="Confirm a developer is able to add the changed file to the local repository."
        ,x="No error."
        ,p="git", a=["add", "."], f=[]
        }
  ,STEP {n=7, r="IUR07"
        ,c="Confirm a developer is able to determine the changed file has been added to the tracked changes on the local git repository."
        ,x="Tracked file is listed."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=8, r="IUR05"
        ,c="Confirm a developer is able to commit the changed file."
        ,x="No error."
        ,p="git", a=["commit", "-m", "Change All [a] to [Z]"], f=[]
        }
  ,STEP {n=9, r="IUR08"
        ,c="Confirm a developer is able to update the remote repository."
        ,x="No error."
        ,p="git", a=["push", "origin", "quick-fix"], f=[]
        }
  ,STEP {n=10, r="IUR07"
        ,c="Confirm a developer is able to establish branch tracking between the remote repository and new branch."
        ,x="Tracking has been established."
        ,p="git", a=["branch", "-u", "origin/quick-fix", "quick-fix"], f=[]
        }
  ,STEP {n=11, r="IUR08"
        ,c="Confirm a developer is able to update the remote repository."
        ,x="No error."
        ,p="git", a=["push"], f=[]
        }
  ,STEP {n=12, r="IUR09"
        ,c="Confirm the developer is able to view difference between master and quick-fix branches."
        ,x="Differences are listed."
        ,p="git", a=["diff", "master..quick-fix"], f=[]
        }
  ,STEP {n=13, r="IUR07"
        ,c="Confirm a developer is able to verify branches have been linked."
        ,x="Branch linkage is established."
        ,p="git", a=["branch", "-vv"], f=[]
        }
  ,STEP {n=14, r="IUR07"
        ,c="Confirm a developer is able to review commits made to repository."
        ,x="Update has been processed."
        ,p="git", a=["log", "--oneline", "-3"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN createQuickFixPath
  withDirectory quicksort1Path $
      runRecipe createQuickFix createQuickFixPath WriteMode
