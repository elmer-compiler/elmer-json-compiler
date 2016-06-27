{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Docs.AST where

import qualified Data.Map as Map

import qualified Elm.Compiler.Type as Type
import qualified Reporting.Annotation as A

import GHC.Generics (Generic)
import qualified Data.Aeson as Json

-- FULL DOCUMENTATION

data Docs t = Docs
    { comment :: String
    , aliases :: Map.Map String (A.Located Alias)
    , types :: Map.Map String (A.Located Union)
    , values :: Map.Map String (A.Located (Value t))
    } deriving (Generic, Json.ToJSON)


type Centralized = Docs (Maybe Type.Type)

type Checked = Docs Type.Type


-- VALUE DOCUMENTATION

data Alias = Alias
    { aliasComment :: Maybe String
    , aliasArgs :: [String]
    , aliasType :: Type.Type
    } deriving (Generic, Json.ToJSON)


data Union = Union
    { unionComment :: Maybe String
    , unionArgs :: [String]
    , unionCases :: [(String, [Type.Type])]
    } deriving (Generic, Json.ToJSON)


data Value t = Value
    { valueComment :: Maybe String
    , valueType :: t
    , valueAssocPrec :: Maybe (String,Int)
    } deriving (Generic, Json.ToJSON)
