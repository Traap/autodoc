module CheckInstall.Protocol (runTestSteps) where

import Settings.Constants
import System.IO
import TestRunner.Directory
import TestRunner.Tester
import TestRunner.Step

checkInstall :: [Step]
checkInstall =
  [STEP {n=1, r="IUR01"
        ,c="Confirm StarterkitProtocls has been installed."
        ,x="StarterkitProtocols installation location is listed."
        ,p="which"
        ,a=["StarterkitProtocols"]
        ,f=[]
        }
  ]

runTestSteps :: IO ()
runTestSteps = do
    ensureDirectoryExists CLEAN checkInstallPath
    runRecipe checkInstall checkInstallPath WriteMode

