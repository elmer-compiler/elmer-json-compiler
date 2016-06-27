{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module AST.Effects where

import qualified AST.Type as Type
import qualified Elm.Package as Pkg
import qualified Reporting.Annotation as A
import qualified Reporting.Region as R


import GHC.Generics
import qualified Data.Aeson as Json

-- EFFECTS


data Effects pkg ports
  = None
  | Manager pkg Info
  | Port ports
  deriving (Generic, Json.ToJSON)


type Raw =
  Effects () [A.Commented PortRaw]


type Canonical =
  Effects Pkg.Name [A.Commented PortCanonical]



-- EFFECT MANAGERS


data Info =
  Info
    { _tag :: R.Region
    , _init :: R.Region
    , _onEffects :: R.Region
    , _onSelfMsg :: R.Region
    , _managerType :: ManagerType
    } deriving (Generic, Json.ToJSON)


data ManagerType
  = CmdManager (A.Located String)
  | SubManager (A.Located String)
  | FxManager (A.Located String) (A.Located String)
  deriving (Generic, Json.ToJSON)



-- FOREIGN EFFECTS


data PortRaw =
  PortRaw
    { _rawName :: String
    , _rawType :: Type.Raw
    }


data PortCanonical =
  PortCanonical
    { _name :: String
    , _kind :: Kind
    , _type :: Type.Canonical
    } deriving (Generic, Json.ToJSON)


data Kind
  = Outgoing Type.Canonical
  | Incoming Type.Canonical
  deriving (Generic, Json.ToJSON)
