module CreateRepo.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

createRepo :: [Step]
createRepo =
  [STEP {n=1, r="IUR03"
        ,c="Confirm a developer is able to touch a file named f1."
        ,x="No error."
        ,p="touch", a=["f1"], f=[]
        }
  ,STEP {n=2, r="IUR03"
        ,c="Confirm a developer is able to touch a file named f2."
        ,x="No error."
        ,p="touch", a=["f2"], f=[]
        }
  ,STEP {n=3, r="IUR03"
        ,c="Confirm a developer is able to list newly touched files."
        ,x="Directory listing has newly touched files."
        ,p="ls", a=["-la"], f=[]
        }
  ,STEP {n=4, r="IUR02"
        ,c="Confirm a developer is able to initialize a local repo."
        ,x="No error."
        ,p="git", a=["init"], f=[]
        }
  ,STEP {n=5, r="IUR03"
        ,c="Confirm a developer is able to add file f1 to a local repo."
        ,x="No error."
        ,p="git", a=["add", "f1"], f=[]
        }
  ,STEP {n=6, r="IUR03"
        ,c="Confirm a developer is able to add file f2 to a local repo."
        ,x="No error."
        ,p="git", a=["add", "f2"], f=[]
        }
  ,STEP {n=7, r="IUR03"
        ,c="Confirm a developer is able to touch a file named f3."
        ,x="No error."
        ,p="touch", a=["f3"], f=[]
        }
  ,STEP {n=8, r="IUR03"
        ,c="Confirm a developer is able to touch a file named f4."
        ,x="No error."
        ,p="touch", a=["f4"], f=[]
        }
  ,STEP {n=9, r="IUR07"
        ,c="Confirm a developer has obtained a list of tracked and untracked repo changes."
        ,x="Status shows tracked files f1 and f2 and untracked files f3 and f4."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=10, r="IUR07"
        ,c="Confirm a developer is able to obtain a list of untracked files."
        ,x="Untracked files f3 and f4 are listed."
        ,p="git", a=["clean", "-n"], f=[]
        }
  ,STEP {n=11, r="IUR07"
        ,c="Confirm a developer is able to remove untracked files."
        ,x="Untracked files f3 and f4 are removed."
        ,p="git", a=["clean", "-f"], f=[]
        }
  ,STEP {n=12, r="IUR05"
        ,c="Confirm a developer is able to commit files f1 and f2 to the local repo."
        ,x="No errror."
        ,p="git", a=["commit", "-m", "Initial-commit."], f=[]
        }
  ,STEP {n=13, r="IUR07"
        ,c="Confirm a developer is able determine tracked files have been committed to local repo."
        ,x="The working directory is clean."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=14, r="IUR07"
        ,c="Confirm a developer is able to list commits to local repo."
        ,x="Commit has been processed."
        ,p="git", a=["log", "--all"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN createRepoPath
  withDirectory package0Path $
       runRecipe createRepo createRepoPath WriteMode
