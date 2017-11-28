{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_redcode (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/bin"
libdir     = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/lib/x86_64-osx-ghc-8.0.2/redcode-0.1.0.0-7IgAiGeGcRe3OuOVxdAZUD"
dynlibdir  = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/share/x86_64-osx-ghc-8.0.2/redcode-0.1.0.0"
libexecdir = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/libexec"
sysconfdir = "/Users/dylanhobbs/haskell/redcode/.stack-work/install/x86_64-osx/lts-9.14/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "redcode_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "redcode_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "redcode_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "redcode_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "redcode_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "redcode_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
