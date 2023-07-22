{-# LANGUAGE OverloadedStrings #-}

import           Network.HaskellNet.IMAP.SSL
import qualified Data.ByteString.Char8 as B

username :: [Char]
username = "test@test.com"
password :: [Char]
password = "@$%kW4CuDfpTQqY8wbN7NPhY"

imapTest :: IO ()
imapTest = do
    c <- connectIMAPSSLWithSettings "imap.kolabnow.com" cfg
    login c username password
    B.putStrLn "Printing mboxes"
    mboxes <- list c
    mapM_ print mboxes
    select c "INBOX"
    msgs <- search c [FROMs "notificacion@notificacionesbaccr.com"]
    let firstMsg = head msgs
    msgContent <- fetch c firstMsg


    B.putStrLn "Messages"
    B.putStrLn msgContent
    logout c
  where cfg = defaultSettingsIMAPSSL { sslMaxLineLength = 100000 }

--smtpTest = doSMTPSTARTTLS "smtp.gmail.com" $ \c -> do
    --authSucceed <- SMTP.authenticate LOGIN username password c
    --if authSucceed
      --then sendPlainTextMail recipient username subject body c
      --else print "Authentication error."
  --where subject = "Test message"
        --body    = "This is a test message"

main :: IO ()
main = imapTest >> return ()
