module Mail (sendAlert) where

import Network.Mail.Client.Gmail
import Network.Mail.Mime
import Config

import qualified Data.Text as T
import qualified Data.Text.Lazy as LT

sendAlert config = (sendGmail username' password'
                    fromAddress toAddress cc bcc
                    subject' body' attachments)
  where username' = LT.pack $ username config
        password' = LT.pack $ password config
        subject' = T.pack $ subject config
        body' = LT.pack $ body config
        fromAddress = Address (Just fromAddressLabel') fromAddressEmail'
        toAddress = [Address (Just toAddressLabel') toAddressEmail']
        fromAddressLabel' = T.pack $ fromAddressLabel config
        fromAddressEmail' = T.pack $ fromAddressEmail config
        toAddressLabel' = T.pack $ toAddressLabel config
        toAddressEmail' = T.pack $ toAddressEmail config
        cc = []
        bcc = []
        attachments = []

