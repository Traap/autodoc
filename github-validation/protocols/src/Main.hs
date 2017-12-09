module Main (main) where

import qualified CheckInstall.Protocol as CheckInstall
import qualified CloneRepo.Protocol as CloneRepo
import qualified CreateQuickFix.Protocol as CreateQuickFix
import qualified CreateRepo.Protocol as CreateRepo
import qualified GitConfig.Protocol as GitConfig
import qualified MergeQuickFix.Protocol as MergeQuickFix
import qualified RevertDelete.Protocol as RevertDelete
import qualified TagCommits.Protocol as TagCommits
import qualified UndoQuickFix.Protocol as UndoQuickFix

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
  ,PROTOCOL {pn =GitConfig.runTestSteps
            ,msg="Running GitConfig protocol."
            }
  ,PROTOCOL {pn =CloneRepo.runTestSteps
            ,msg="Running CloneRepo protocol."
            }
  ,PROTOCOL {pn =CreateRepo.runTestSteps
            ,msg="Running CreateRepo protocol."
            }
  ,PROTOCOL {pn =RevertDelete.runTestSteps
            ,msg="Running RevertDelete protocol."
            }
  ,PROTOCOL {pn =CreateQuickFix.runTestSteps
            ,msg="Running CreateQuickFix protocol."
            }
  ,PROTOCOL {pn =UndoQuickFix.runTestSteps
            ,msg="Running UndoQuickFix protocol."
            }
  ,PROTOCOL {pn =MergeQuickFix.runTestSteps
            ,msg="Running MergeQuickFix protocol."
            }
  ,PROTOCOL {pn =TagCommits.runTestSteps
            ,msg="Running TagCommits protocol."
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
  putStrLn "Running Git Validaiton Protocols"
  runProtocols protocols directories

  putStrLn "Recording equipment list."
  recordEquipment equipmentPath WriteMode

  putStrLn "Generating tool validation report."
  toPDF tmpReportPath testPackageName

  putStrLn "Moving tool validation output to test-output folder."
  moveOutputToArchiveFolder rootTestPath

  exitSuccess
