{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Module      : Network.AWS.OpsWorks.GetHostnameSuggestion
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

-- | Gets a generated host name for the specified layer, based on the current
-- host name theme.
--
-- __Required Permissions__: To use this action, an IAM user must have a
-- Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see
-- <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html Managing User Permissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_GetHostnameSuggestion.html>
module Network.AWS.OpsWorks.GetHostnameSuggestion
    (
    -- * Request
      GetHostnameSuggestion
    -- ** Request constructor
    , getHostnameSuggestion
    -- ** Request lenses
    , ghsLayerId

    -- * Response
    , GetHostnameSuggestionResponse
    -- ** Response constructor
    , getHostnameSuggestionResponse
    -- ** Response lenses
    , ghsrHostname
    , ghsrLayerId
    , ghsrStatus
    ) where

import           Network.AWS.OpsWorks.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'getHostnameSuggestion' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ghsLayerId'
newtype GetHostnameSuggestion = GetHostnameSuggestion'
    { _ghsLayerId :: Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetHostnameSuggestion' smart constructor.
getHostnameSuggestion :: Text -> GetHostnameSuggestion
getHostnameSuggestion pLayerId =
    GetHostnameSuggestion'
    { _ghsLayerId = pLayerId
    }

-- | The layer ID.
ghsLayerId :: Lens' GetHostnameSuggestion Text
ghsLayerId = lens _ghsLayerId (\ s a -> s{_ghsLayerId = a});

instance AWSRequest GetHostnameSuggestion where
        type Sv GetHostnameSuggestion = OpsWorks
        type Rs GetHostnameSuggestion =
             GetHostnameSuggestionResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 GetHostnameSuggestionResponse' <$>
                   (x .?> "Hostname") <*> (x .?> "LayerId") <*>
                     (pure (fromEnum s)))

instance ToHeaders GetHostnameSuggestion where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("OpsWorks_20130218.GetHostnameSuggestion" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON GetHostnameSuggestion where
        toJSON GetHostnameSuggestion'{..}
          = object ["LayerId" .= _ghsLayerId]

instance ToPath GetHostnameSuggestion where
        toPath = const "/"

instance ToQuery GetHostnameSuggestion where
        toQuery = const mempty

-- | Contains the response to a @GetHostnameSuggestion@ request.
--
-- /See:/ 'getHostnameSuggestionResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ghsrHostname'
--
-- * 'ghsrLayerId'
--
-- * 'ghsrStatus'
data GetHostnameSuggestionResponse = GetHostnameSuggestionResponse'
    { _ghsrHostname :: !(Maybe Text)
    , _ghsrLayerId  :: !(Maybe Text)
    , _ghsrStatus   :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetHostnameSuggestionResponse' smart constructor.
getHostnameSuggestionResponse :: Int -> GetHostnameSuggestionResponse
getHostnameSuggestionResponse pStatus =
    GetHostnameSuggestionResponse'
    { _ghsrHostname = Nothing
    , _ghsrLayerId = Nothing
    , _ghsrStatus = pStatus
    }

-- | The generated host name.
ghsrHostname :: Lens' GetHostnameSuggestionResponse (Maybe Text)
ghsrHostname = lens _ghsrHostname (\ s a -> s{_ghsrHostname = a});

-- | The layer ID.
ghsrLayerId :: Lens' GetHostnameSuggestionResponse (Maybe Text)
ghsrLayerId = lens _ghsrLayerId (\ s a -> s{_ghsrLayerId = a});

-- | FIXME: Undocumented member.
ghsrStatus :: Lens' GetHostnameSuggestionResponse Int
ghsrStatus = lens _ghsrStatus (\ s a -> s{_ghsrStatus = a});
