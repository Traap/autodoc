module Settings.Constants
  ( checkInstallPath
  , equipmentPath
  , protocolPath
  , reportPath
  , rootTestPath
  , testOutputPath
  , testPackageName
  , tmpReportPath
  ) where

testPackageName :: [Char]
testPackageName = "starterkit.tex"

rootTestPath :: [Char]
rootTestPath = "/tmp/test-output"

testOutputPath :: [Char]
testOutputPath = rootTestPath ++ "/starterkit"

equipmentPath :: [Char]
equipmentPath = testOutputPath ++ "/equipment"

protocolPath :: [Char]
protocolPath = testOutputPath ++ "/protocol"

reportPath :: [Char]
reportPath = testOutputPath ++ "/report"

tmpReportPath :: [Char]
tmpReportPath = reportPath

checkInstallPath :: [Char]
checkInstallPath = protocolPath ++ "/CheckInstall"


