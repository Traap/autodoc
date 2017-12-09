module RevertDelete.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

delete :: [Step]
delete =
  [STEP {n=1, r="IUR04"
        ,c="Confirm a developer is able to pull the remote repository to the local repository."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=2, r="IUR03"
        ,c="Confirm a developer is able to remove all files from the local repository."
        ,x="No error."
        ,p="git", a=["rm", "-r", "quicksort/"], f=[]
        }
  ,STEP {n=3, r="IUR05"
        ,c="Confirm a developer is able to commit file removals."
        ,x="No error."
        ,p="git", a=["commit", "-m", "Remove all quicksort files."], f=[]
        }
  ,STEP {n=4, r="IUR08"
        ,c="Confirm a developer is able to update the remote repository."
        ,x="No Error."
        ,p="git", a=["push"], f=[]
        }
  ,STEP {n=5, r="IUR07"
        ,c="Confirm a developer is able to review the commits to the repository."
        ,x="Update has been processed."
        ,p="git", a=["log", "--oneline", "-3"], f=[]
        }
  ]

revert :: [Step]
revert =
  [STEP {n=6, r="IUR04"
        ,c="Confirm a developer is able to pull the remote repository to the local repository."
        ,x="No error."
        ,p="git", a=["pull"], f=[]
        }
  ,STEP {n=7, r="IUR03"
        ,c="Confirm a developer is able to unto the delete operation."
        ,x="No error."
        ,p="git", a=["revert", "--no-edit", "HEAD"], f=[]
        }
  ,STEP {n=8, r="IUR08"
        ,c="Confirm a developer is able to update the remote repository."
        ,x="No error."
        ,p="git", a=["push"], f=[]
        }
  ,STEP {n=9, r="IUR07"
        ,c="Confirm a developer is able to review the commits to the repository."
        ,x="Update has been processed."
        ,p="git", a=["log", "--oneline", "-3"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN revertDeletePath
  withDirectory repo1Path $ do
       runRecipe delete revertDeletePath WriteMode
       runRecipe revert revertDeletePath AppendMode
