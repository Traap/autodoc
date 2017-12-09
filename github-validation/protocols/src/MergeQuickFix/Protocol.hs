module MergeQuickFix.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

mergeQuickFix :: [Step]
mergeQuickFix =
  [STEP {n=1, r="IUR02"
        ,c="Confirm a developer is able to checkout the master branch to the local repository."
        ,x="No error."
        ,p="git", a=["checkout", "master"], f=[]
        }
  ,STEP {n=2, r="IUR04"
        ,c="Confirm a developer is able to update the local copy of their master branch."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=3, r="IUR06"
        ,c="Confirm a developer is able to checkout a quick-fix branch to their local repository."
        ,x="No error."
        ,p="git", a=["checkout", "quick-fix"], f=[]
        }
  ,STEP {n=4, r="IUR04"
        ,c="Confirm a developer is able to update the local copy of their quick-bix branch."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=5, r="IUR06"
        ,c="Confirm a developer is able to return to their master branch."
        ,x="No error."
        ,p="git", a=["checkout", "master"], f=[]
        }
  ,STEP {n=6, r="IUR09"
        ,c="Confirm a developer is able to review the differences between their master branch and quick-fix branch."
        ,x="Differences between master and quick-fix branch are listed."
        ,p="git", a=["diff", "master..quick-fix"], f=[]
        }
  ,STEP {n=7, r="IUR07"
        ,c="Confirm a developer is able to determine the quick-fix branch has not been merged with the master branch."
        ,x="Quick-fix branch has not been merged."
        ,p="git", a=["branch", "--merged"], f=[]
        }
  ,STEP {n=8, r="IUR08"
        ,c="Confirm a developer is able to merge the quick-fix branch into the master branch."
        ,x="No error."
        ,p="git", a=["merge", "quick-fix"], f=[]
        }
  ,STEP {n=9, r="IUR08"
        ,c="Confirm a developer is able to update the remote repository with the results of the merge operation."
        ,x="No error."
        ,p="git", a=["push"], f=[]
        }
  ,STEP {n=10, r="IUR07"
        ,c="Confirm a developer is able to review the results of the merge operation."
        ,x="Quick-fix branch has been merged."
        ,p="git", a=["branch", "--merged"], f=[]
        }
  ,STEP {n=11, r="IUR03"
        ,c="Confirm a developer is able to delete the quick-fix branch from the local repository."
        ,x="Local quick-fix branch has been removed."
        ,p="git", a=["branch", "--delete", "quick-fix"], f=[]
        }
  ,STEP {n=12, r="IUR08"
        ,c="Confirm a developer is able to delete the quick-fix branch from the remote repository."
        ,x="No error."
        ,p="git", a=["push", "origin", "--delete", "quick-fix"], f=[]
        }
  ,STEP {n=13, r="IUR07"
        ,c="Confirm a developer is able to determine the remote and local quick-fix branches have been deleted."
        ,x="Quick-fix branches have been deleted."
        ,p="git", a=["branch", "-vv"], f=[]
        }
  ,STEP {n=14, r="IUR07"
        ,c="Confirm a developer is able to review a list of changes made to the repository."
        ,x="Commits are listed."
        ,p="git", a=["log", "--oneline", "-3"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN mergeQuickFixPath
  withDirectory repo1Path $ do
       runRecipe mergeQuickFix mergeQuickFixPath WriteMode
