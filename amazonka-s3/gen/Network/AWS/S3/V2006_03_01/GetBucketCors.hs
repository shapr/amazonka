{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.S3.V2006_03_01.GetBucketCors
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns the cors configuration for the bucket.
module Network.AWS.S3.V2006_03_01.GetBucketCors where

import Network.AWS.Request.RestS3
import Network.AWS.S3.V2006_03_01.Types
import Network.AWS.Prelude

data GetBucketCors = GetBucketCors
    { _gbcrBucket :: BucketName
    } deriving (Show, Generic)

makeLenses ''GetBucketCors

instance ToPath GetBucketCors where
    toPath GetBucketCors{..} = mconcat
        [ "/"
        , toBS _gbcrBucket
        ]

instance ToQuery GetBucketCors where
    toQuery GetBucketCors{..} = mconcat
        [ "cors"
        ]

instance ToHeaders GetBucketCors

instance ToBody GetBucketCors

data GetBucketCorsResponse = GetBucketCorsResponse
    { _gbcoCORSRules :: [CORSRule]
    } deriving (Show, Generic)

makeLenses ''GetBucketCorsResponse

instance FromXML GetBucketCorsResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest GetBucketCors where
    type Sv GetBucketCors = S3
    type Rs GetBucketCors = GetBucketCorsResponse

    request = get
    response _ = xmlResponse
