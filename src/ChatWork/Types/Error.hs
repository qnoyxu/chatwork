{-# LANGUAGE DeriveGeneric #-}

module ChatWork.Types.Error
    ( ChatWorkErrors(..)
    ) where

import           ChatWork.Utils    (strLength)
import           Data.Aeson        (FromJSON (..), ToJSON (..),
                                    genericParseJSON, genericToJSON)
import           Data.Aeson.Casing (aesonDrop, snakeCase)
import           Data.Text         (Text)
import           GHC.Generics      (Generic)
import           Control.Exception (Exception)
import           Data.Typeable     (Typeable)

-- |
-- when error, chatwork is response:
-- { "errors": ["Invalid API token"] }
--
-- see : http://developer.chatwork.com/ja/endpoints.html

newtype ChatWorkErrors = ChatWorkErrors { getErrors :: [Text] } deriving (Eq, Show, Generic, Typeable)

instance ToJSON ChatWorkErrors where
  toJSON = genericToJSON $ aesonDrop (strLength "get") snakeCase
instance FromJSON ChatWorkErrors where
  parseJSON = genericParseJSON $ aesonDrop (strLength "get") snakeCase
instance Exception ChatWorkErrors
