{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Module      : Network.AWS.CloudWatchLogs.CreateLogStream
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Creates a new log stream in the specified log group. The name of the log
-- stream must be unique within the log group. There is no limit on the
-- number of log streams that can exist in a log group.
--
-- You must use the following guidelines when naming a log stream:
--
-- -   Log stream names can be between 1 and 512 characters long.
-- -   The \':\' colon character is not allowed.
--
-- <http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogStream.html>
module Network.AWS.CloudWatchLogs.CreateLogStream
    (
    -- * Request
      CreateLogStream
    -- ** Request constructor
    , createLogStream
    -- ** Request lenses
    , clsLogGroupName
    , clsLogStreamName

    -- * Response
    , CreateLogStreamResponse
    -- ** Response constructor
    , createLogStreamResponse
    ) where

import           Network.AWS.CloudWatchLogs.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'createLogStream' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'clsLogGroupName'
--
-- * 'clsLogStreamName'
data CreateLogStream = CreateLogStream'
    { _clsLogGroupName  :: !Text
    , _clsLogStreamName :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'CreateLogStream' smart constructor.
createLogStream :: Text -> Text -> CreateLogStream
createLogStream pLogGroupName pLogStreamName =
    CreateLogStream'
    { _clsLogGroupName = pLogGroupName
    , _clsLogStreamName = pLogStreamName
    }

-- | The name of the log group under which the log stream is to be created.
clsLogGroupName :: Lens' CreateLogStream Text
clsLogGroupName = lens _clsLogGroupName (\ s a -> s{_clsLogGroupName = a});

-- | The name of the log stream to create.
clsLogStreamName :: Lens' CreateLogStream Text
clsLogStreamName = lens _clsLogStreamName (\ s a -> s{_clsLogStreamName = a});

instance AWSRequest CreateLogStream where
        type Sv CreateLogStream = CloudWatchLogs
        type Rs CreateLogStream = CreateLogStreamResponse
        request = postJSON
        response = receiveNull CreateLogStreamResponse'

instance ToHeaders CreateLogStream where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("Logs_20140328.CreateLogStream" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON CreateLogStream where
        toJSON CreateLogStream'{..}
          = object
              ["logGroupName" .= _clsLogGroupName,
               "logStreamName" .= _clsLogStreamName]

instance ToPath CreateLogStream where
        toPath = const "/"

instance ToQuery CreateLogStream where
        toQuery = const mempty

-- | /See:/ 'createLogStreamResponse' smart constructor.
data CreateLogStreamResponse =
    CreateLogStreamResponse'
    deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'CreateLogStreamResponse' smart constructor.
createLogStreamResponse :: CreateLogStreamResponse
createLogStreamResponse = CreateLogStreamResponse'
