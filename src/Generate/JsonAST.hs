{-# LANGUAGE OverloadedStrings #-}
module Generate.JsonAST (generate) where

import qualified AST.Module as Module
import qualified AST.Module.Name as ModuleName
import qualified Data.Aeson as Json
import qualified Data.Text.Lazy as LazyText

import qualified Reporting.Annotation as Annotation
import qualified Reporting.Region as R

import Data.Text.Lazy.Builder (toLazyText)
import Data.Aeson.Encode (encodeToTextBuilder)
import Data.Aeson ((.=))

generate :: Module.Optimized -> LazyText.Text
generate =
  toLazyText . encodeToTextBuilder . Json.toJSON

