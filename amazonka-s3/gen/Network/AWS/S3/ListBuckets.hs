{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Module      : Network.AWS.S3.ListBuckets
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

-- | Returns a list of all buckets owned by the authenticated sender of the
-- request.
--
-- <http://docs.aws.amazon.com/AmazonS3/latest/API/ListBuckets.html>
module Network.AWS.S3.ListBuckets
    (
    -- * Request
      ListBuckets
    -- ** Request constructor
    , listBuckets

    -- * Response
    , ListBucketsResponse
    -- ** Response constructor
    , listBucketsResponse
    -- ** Response lenses
    , lbrBuckets
    , lbrOwner
    , lbrStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.S3.Types

-- | /See:/ 'listBuckets' smart constructor.
data ListBuckets =
    ListBuckets'
    deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'ListBuckets' smart constructor.
listBuckets :: ListBuckets
listBuckets = ListBuckets'

instance AWSRequest ListBuckets where
        type Sv ListBuckets = S3
        type Rs ListBuckets = ListBucketsResponse
        request = get
        response
          = receiveXML
              (\ s h x ->
                 ListBucketsResponse' <$>
                   (x .@? "Buckets" .!@ mempty >>=
                      may (parseXMLList "Bucket"))
                     <*> (x .@? "Owner")
                     <*> (pure (fromEnum s)))

instance ToHeaders ListBuckets where
        toHeaders = const mempty

instance ToPath ListBuckets where
        toPath = const "/"

instance ToQuery ListBuckets where
        toQuery = const mempty

-- | /See:/ 'listBucketsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lbrBuckets'
--
-- * 'lbrOwner'
--
-- * 'lbrStatus'
data ListBucketsResponse = ListBucketsResponse'
    { _lbrBuckets :: !(Maybe [Bucket])
    , _lbrOwner   :: !(Maybe Owner)
    , _lbrStatus  :: !Int
    } deriving (Eq,Show,Data,Typeable,Generic)

-- | 'ListBucketsResponse' smart constructor.
listBucketsResponse :: Int -> ListBucketsResponse
listBucketsResponse pStatus =
    ListBucketsResponse'
    { _lbrBuckets = Nothing
    , _lbrOwner = Nothing
    , _lbrStatus = pStatus
    }

-- | FIXME: Undocumented member.
lbrBuckets :: Lens' ListBucketsResponse [Bucket]
lbrBuckets = lens _lbrBuckets (\ s a -> s{_lbrBuckets = a}) . _Default;

-- | FIXME: Undocumented member.
lbrOwner :: Lens' ListBucketsResponse (Maybe Owner)
lbrOwner = lens _lbrOwner (\ s a -> s{_lbrOwner = a});

-- | FIXME: Undocumented member.
lbrStatus :: Lens' ListBucketsResponse Int
lbrStatus = lens _lbrStatus (\ s a -> s{_lbrStatus = a});
