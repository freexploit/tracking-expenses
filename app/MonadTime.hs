module MonadTime(MonadTime(..)) where

import Flow
import System.Time
import App
import Control.Monad.IO.Class (liftIO)

-- Negate a TimeDiff
negateTimeDiff :: TimeDiff -> TimeDiff
negateTimeDiff td = TimeDiff { tdYear = -(tdYear td), tdMonth = -(tdMonth td), tdDay = -(tdDay td), tdHour = -(tdHour td), tdMin = -(tdMin td), tdSec = -(tdSec td), tdPicosec = -(tdPicosec td) }

class (Monad m) => MonadTime m where 
    getCurrentDay :: m CalendarTime
    daysAgo :: Int -> m  CalendarTime



instance MonadTime AppM where
    getCurrentDay = AppM <| liftIO <| do
        clockTime <- getClockTime
        toCalendarTime clockTime

    daysAgo  d = AppM <| liftIO <| do
        now <- getClockTime

        -- Convert to CalendarTime
        --let calendarTimeNow = toUTCTime' now

        -- Create a TimeDiff for 2 days
        let days = noTimeDiff { tdDay = d  }

        -- Get the time for 2 days ago
        let daysAgoClock = addToClockTime (negateTimeDiff days) now
        toCalendarTime daysAgoClock
