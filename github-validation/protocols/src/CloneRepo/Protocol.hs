module CloneRepo.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory

import TestRunner.Tester
import TestRunner.Step

clone :: [Step]
clone =
  [STEP {n=1, r="IUR04"
        ,c="Confirm a developer is able to clone a remote repository."
        ,x="No error."
        ,p="git", a=["clone", repoURL], f=[]
        }
  ]

verify ::[Step]
verify =
  [STEP {n=2, r="IUR07"
        ,c="Confirm a developer is working on master branch and up-to-date after cloning a remote repository."
        ,x="Branch information is displayed."
        ,p="git", a=["status"], f=[]
        }
  ,STEP {n=3, r="IUR04"
        ,c="Confirm a developer is able to review a set of tracked repositories ."
        ,x="Fetch and push URLs are identical."
        ,p="git", a=["remote", "-v"], f=[]
        }
  ,STEP {n=4, r="IUR04"
        ,c="Confirm a developer's local and remote branches are mapped to master branch."
        ,x="Local and remote branch are mapped to master branch."
        ,p="git", a=["branch", "-a"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
  ensureDirectoryExists CLEAN cloneRepoPath
  ensureDirectoryExists CLEAN package1Path
  withDirectory package1Path $
      runRecipe clone cloneRepoPath WriteMode
  withDirectory repo1Path $
      runRecipe verify cloneRepoPath AppendMode
