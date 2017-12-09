module Settings.Constants
  ( checkInstallPath
  , cloneRepoPath
  , createQuickFixPath
  , createRepoPath
  , equipmentPath
  , gitConfigPath
  , mergeQuickFixPath
  , package0Path
  , package1Path
  , package2Path
  , protocolPath
  , quicksort1Path
  , quicksort2Path
  , repo1Path
  , repo2Path
  , repoHost
  , repoName
  , repoPort
  , repoURL
  , reportPath
  , revertDeletePath
  , rootTestPath
  , tagCommitsPath
  , testOutputPath
  , testPackageName
  , tmpReportPath
  , undoQuickFixPath
  ) where

testPackageName :: [Char]
testPackageName = "rpt-067811.tex"

rootTestPath :: [Char]
rootTestPath = "/tmp/test-output"

testOutputPath :: [Char]
testOutputPath = rootTestPath ++ "/git"

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

cloneRepoPath :: [Char]
cloneRepoPath = protocolPath ++ "/CloneRepo"

createQuickFixPath :: [Char]
createQuickFixPath = protocolPath ++ "/CreateQuickFix"

createRepoPath :: [Char]
createRepoPath = protocolPath ++ "/CreateRepo"

gitConfigPath :: [Char]
gitConfigPath = protocolPath ++ "/GitConfig"

mergeQuickFixPath :: [Char]
mergeQuickFixPath  = protocolPath ++ "/MergeQuickFix"

revertDeletePath :: [Char]
revertDeletePath = protocolPath ++ "/RevertDelete"

undoQuickFixPath :: [Char]
undoQuickFixPath = protocolPath ++ "/UndoQuickFix"

tagCommitsPath :: [Char]
tagCommitsPath = protocolPath ++ "/TagCommits"

package0Path :: [Char]
package0Path = testOutputPath ++ "/package-0"

package1Path :: [Char]
package1Path = testOutputPath ++ "/package-1"

package2Path :: [Char]
package2Path = testOutputPath ++ "/package-2"

-- The Git Validation Package can be run against other service providers such as
-- GitHub.Com or GitLabs.com by changing repoHost, repoPort, and repoName to
-- something of your choosing. However, this program does require a rudimentary
-- program named quicksort written in Haskell to work.  Therefore, copy the
-- quicksort folder into your new repository and push it.  You will also want to
-- review the TagCommit/ protocol for instruction on required tag names.
repoHost :: [Char]
repoHost = "ssh://git@stash.amgencss.fpcomplete.com"

repoPort :: [Char]
repoPort = "2222"

repoName :: [Char]
repoName = "/hmst-git-validation"

repo1Path :: [Char]
repo1Path = package1Path ++ repoName

repo2Path :: [Char]
repo2Path = package2Path ++ repoName

quicksort1Path :: [Char]
quicksort1Path = repo1Path ++ "/quicksort/src"

quicksort2Path :: [Char]
quicksort2Path = repo2Path ++ "/quicksort/src"

repoURL :: [Char]
repoURL = repoHost ++ ":" ++ repoPort ++ "/hmst" ++ repoName ++ ".git"
