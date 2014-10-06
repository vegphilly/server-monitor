module Config where

data Config = Config { username :: String,
                       password :: String,
                       subject :: String,
                       body :: String,
                       fromAddressLabel :: String,
                       fromAddressEmail :: String,
                       toAddressLabel :: String,
                       toAddressEmail :: String,
                       serverUrl :: String,
                       serverHeaderCriteria :: String
                     } deriving Read
