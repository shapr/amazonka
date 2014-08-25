{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.CloudSearch.V2013_01_01.IndexDocuments
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Tells the search domain to start indexing its documents using the latest
-- indexing options. This operation must be invoked to activate options whose
-- OptionStatus is RequiresIndexDocuments.
module Network.AWS.CloudSearch.V2013_01_01.IndexDocuments where

import Network.AWS.Request.Query
import Network.AWS.CloudSearch.V2013_01_01.Types
import Network.AWS.Prelude

data IndexDocuments = IndexDocuments
    { _idrDomainName :: Text
      -- ^ A string that represents the name of a domain. Domain names are
      -- unique across the domains owned by an account within an AWS
      -- region. Domain names start with a letter or number and can
      -- contain the following characters: a-z (lowercase), 0-9, and -
      -- (hyphen).
    } deriving (Show, Generic)

makeLenses ''IndexDocuments

instance ToQuery IndexDocuments where
    toQuery = genericQuery def

data IndexDocumentsResponse = IndexDocumentsResponse
    { _idsFieldNames :: [Text]
      -- ^ The names of the fields that are currently being indexed.
    } deriving (Show, Generic)

makeLenses ''IndexDocumentsResponse

instance FromXML IndexDocumentsResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest IndexDocuments where
    type Sv IndexDocuments = CloudSearch
    type Rs IndexDocuments = IndexDocumentsResponse

    request = post "IndexDocuments"
    response _ = xmlResponse
