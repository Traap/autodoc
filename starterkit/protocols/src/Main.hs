module Main (main) where

import qualified CheckInstall.Protocol as CheckInstall

import Settings.Constants
import System.Exit
import System.IO
import TestRunner.Directory
import TestRunner.Environment
import TestRunner.Latex
import TestRunner.Protocol
import TestRunner.Tester

protocols :: [Protocol]
protocols =
  [PROTOCOL {pn =CheckInstall.runTestSteps
            ,msg="Running CheckInstall protocol."
            }
  ]


directories :: [String]
directories =
  [testOutputPath
  ,protocolPath
  ,equipmentPath
  ,reportPath
  ]

main :: IO ()
main = whenGitClean $ ensureDocker $ do

  putStrLn "Running Starterkit Validaiton Protocols"
  runProtocols protocols directories

  putStrLn "Recording equipment list."
  recordEquipment equipmentPath WriteMode

  putStrLn "Generating tool validation report."
  toPDF tmpReportPath testPackageName

  putStrLn "Moving tool validation output to test-output folder."
  moveOutputToArchiveFolder rootTestPath

  exitSuccess
