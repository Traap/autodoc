module GitConfig.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

gitConfig:: [Step]
gitConfig =
  [ STEP {n=1, r="IUR01"
        ,c="Confirm a developer is able to access Git help."
        ,x="Git help is displayed."
        ,p="git", a=["help"], f=[]
        }
  , STEP {n=2, r="IUR01"
        ,c="Confirm a developer is able to initialize the repository."
        ,x="No error."
        ,p="git", a=["init"], f=[]
        }
  ,STEP {n=3, r="IUR01"
        ,c="Confirm a developer is able to configure a Git code pager."
        ,x="No error."
        ,p="git", a=["config","--global", "code.pager", "cat"], f=[]
        }
  ,STEP {n=4, r="IUR01"
        ,c="Confirm a developer is able to configure a Git user name."
        ,x="No error."
        ,p="git", a=["config","--global", "user.name", "System Informatics"], f=[]
        }
  ,STEP {n=5, r="IUR01"
        ,c="Confirm a developer is able to configure a Git user email address."
        ,x="No error."
        ,p="git", a=["config","--global", "user.email", "systeminformatics@amgen.com"], f=[]
        }
  ,STEP {n=6, r="IUR01"
        ,c="Confirm a developer is able to store their Git credentials."
        ,x="No error."
        ,p="git", a=["config","--global", "credential.helper", "store"], f=[]
        }
  ]

verify :: [Step]
verify =
  [STEP {n=6, r="IUR01"
        ,c="Confirm a developer has a properly configured .gitconfig file."
        ,x=".gitconfig file is displayed."
        ,p="cat", a=[".git/config"], f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
    ensureDirectoryExists CLEAN gitConfigPath
    ensureDirectoryExists NOCLEAN package0Path
    withDirectory package0Path $ do
        runRecipe gitConfig gitConfigPath WriteMode
        runRecipe verify gitConfigPath AppendMode
