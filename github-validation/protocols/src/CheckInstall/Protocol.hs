module CheckInstall.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

checkInstall :: [Step]
checkInstall =
  [STEP {n=1, r="IUR00"
        ,c="Confirm GitProtocols has been installed."
        ,x="GitProtocols installation location is listed."
        ,p="which"
        ,a=["GitProtocols"]
        ,f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
    ensureDirectoryExists CLEAN checkInstallPath
    runRecipe checkInstall checkInstallPath WriteMode

