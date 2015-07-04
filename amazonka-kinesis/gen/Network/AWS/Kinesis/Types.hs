{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE LambdaCase         #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Module      : Network.AWS.Kinesis.Types
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

module Network.AWS.Kinesis.Types
    (
    -- * Service
      Kinesis

    -- * Errors
    , _ExpiredIteratorException
    , _InvalidArgumentException
    , _ProvisionedThroughputExceededException
    , _ResourceNotFoundException
    , _ResourceInUseException
    , _LimitExceededException

    -- * ShardIteratorType
    , ShardIteratorType (..)

    -- * StreamStatus
    , StreamStatus (..)

    -- * HashKeyRange
    , HashKeyRange
    , hashKeyRange
    , hkrStartingHashKey
    , hkrEndingHashKey

    -- * PutRecordsRequestEntry
    , PutRecordsRequestEntry
    , putRecordsRequestEntry
    , prreExplicitHashKey
    , prreData
    , prrePartitionKey

    -- * PutRecordsResultEntry
    , PutRecordsResultEntry
    , putRecordsResultEntry
    , prreSequenceNumber
    , prreErrorCode
    , prreErrorMessage
    , prreShardId

    -- * Record
    , Record
    , record
    , recSequenceNumber
    , recData
    , recPartitionKey

    -- * SequenceNumberRange
    , SequenceNumberRange
    , sequenceNumberRange
    , snrEndingSequenceNumber
    , snrStartingSequenceNumber

    -- * Shard
    , Shard
    , shard
    , shaAdjacentParentShardId
    , shaParentShardId
    , shaShardId
    , shaHashKeyRange
    , shaSequenceNumberRange

    -- * StreamDescription
    , StreamDescription
    , streamDescription
    , sdStreamName
    , sdStreamARN
    , sdStreamStatus
    , sdShards
    , sdHasMoreShards

    -- * Tag
    , Tag
    , tag
    , tagValue
    , tagKey
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Sign.V4

-- | Version @2013-12-02@ of the Amazon Kinesis SDK.
data Kinesis

instance AWSService Kinesis where
    type Sg Kinesis = V4
    service = const svc
      where
        svc =
            Service
            { _svcAbbrev = "Kinesis"
            , _svcPrefix = "kinesis"
            , _svcVersion = "2013-12-02"
            , _svcEndpoint = defaultEndpoint svc
            , _svcTimeout = Just 70000000
            , _svcStatus = statusSuccess
            , _svcError = parseJSONError
            , _svcRetry = retry
            }
        retry =
            Exponential
            { _retryBase = 5.0e-2
            , _retryGrowth = 2
            , _retryAttempts = 5
            , _retryCheck = check
            }
        check e
          | has (hasCode "ThrottlingException" . hasStatus 400) e =
              Just "throttling_exception"
          | has (hasCode "Throttling" . hasStatus 400) e = Just "throttling"
          | has (hasStatus 503) e = Just "service_unavailable"
          | has (hasStatus 500) e = Just "general_server_error"
          | has (hasStatus 509) e = Just "limit_exceeded"
          | otherwise = Nothing

-- | The provided iterator exceeds the maximum age allowed.
_ExpiredIteratorException :: AWSError a => Getting (First ServiceError) a ServiceError
_ExpiredIteratorException = _ServiceError . hasCode "ExpiredIteratorException"

-- | A specified parameter exceeds its restrictions, is not supported, or
-- can\'t be used. For more information, see the returned message.
_InvalidArgumentException :: AWSError a => Getting (First ServiceError) a ServiceError
_InvalidArgumentException = _ServiceError . hasCode "InvalidArgumentException"

-- | The request rate is too high, or the requested data is too large for the
-- available throughput. Reduce the frequency or size of your requests. For
-- more information, see
-- <http://docs.aws.amazon.com/general/latest/gr/api-retries.html Error Retries and Exponential Backoff in AWS>
-- in the /AWS General Reference/.
_ProvisionedThroughputExceededException :: AWSError a => Getting (First ServiceError) a ServiceError
_ProvisionedThroughputExceededException =
    _ServiceError . hasCode "ProvisionedThroughputExceededException"

-- | The requested resource could not be found. It might not be specified
-- correctly, or it might not be in the @ACTIVE@ state.
_ResourceNotFoundException :: AWSError a => Getting (First ServiceError) a ServiceError
_ResourceNotFoundException =
    _ServiceError . hasCode "ResourceNotFoundException"

-- | The resource is not available for this operation. For example, you
-- attempted to split a shard but the stream is not in the @ACTIVE@ state.
_ResourceInUseException :: AWSError a => Getting (First ServiceError) a ServiceError
_ResourceInUseException = _ServiceError . hasCode "ResourceInUseException"

-- | The requested resource exceeds the maximum number allowed, or the number
-- of concurrent stream requests exceeds the maximum number allowed (5).
_LimitExceededException :: AWSError a => Getting (First ServiceError) a ServiceError
_LimitExceededException = _ServiceError . hasCode "LimitExceededException"

data ShardIteratorType
    = AfterSequenceNumber
    | ATSequenceNumber
    | TrimHorizon
    | Latest
    deriving (Eq,Ord,Read,Show,Enum,Data,Typeable,Generic)

instance FromText ShardIteratorType where
    parser = takeLowerText >>= \case
        "at_sequence_number" -> pure ATSequenceNumber
        "after_sequence_number" -> pure AfterSequenceNumber
        "latest" -> pure Latest
        "trim_horizon" -> pure TrimHorizon
        e -> fromTextError $ "Failure parsing ShardIteratorType from value: '" <> e
           <> "'. Accepted values: at_sequence_number, after_sequence_number, latest, trim_horizon"

instance ToText ShardIteratorType where
    toText = \case
        ATSequenceNumber -> "at_sequence_number"
        AfterSequenceNumber -> "after_sequence_number"
        Latest -> "latest"
        TrimHorizon -> "trim_horizon"

instance Hashable ShardIteratorType
instance ToQuery ShardIteratorType
instance ToHeader ShardIteratorType

instance ToJSON ShardIteratorType where
    toJSON = toJSONText

data StreamStatus
    = Deleting
    | Updating
    | Creating
    | Active
    deriving (Eq,Ord,Read,Show,Enum,Data,Typeable,Generic)

instance FromText StreamStatus where
    parser = takeLowerText >>= \case
        "active" -> pure Active
        "creating" -> pure Creating
        "deleting" -> pure Deleting
        "updating" -> pure Updating
        e -> fromTextError $ "Failure parsing StreamStatus from value: '" <> e
           <> "'. Accepted values: active, creating, deleting, updating"

instance ToText StreamStatus where
    toText = \case
        Active -> "active"
        Creating -> "creating"
        Deleting -> "deleting"
        Updating -> "updating"

instance Hashable StreamStatus
instance ToQuery StreamStatus
instance ToHeader StreamStatus

instance FromJSON StreamStatus where
    parseJSON = parseJSONText "StreamStatus"

-- | The range of possible hash key values for the shard, which is a set of
-- ordered contiguous positive integers.
--
-- /See:/ 'hashKeyRange' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'hkrStartingHashKey'
--
-- * 'hkrEndingHashKey'
data HashKeyRange = HashKeyRange'
    { _hkrStartingHashKey :: !Text
    , _hkrEndingHashKey   :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'HashKeyRange' smart constructor.
hashKeyRange :: Text -> Text -> HashKeyRange
hashKeyRange pStartingHashKey pEndingHashKey =
    HashKeyRange'
    { _hkrStartingHashKey = pStartingHashKey
    , _hkrEndingHashKey = pEndingHashKey
    }

-- | The starting hash key of the hash key range.
hkrStartingHashKey :: Lens' HashKeyRange Text
hkrStartingHashKey = lens _hkrStartingHashKey (\ s a -> s{_hkrStartingHashKey = a});

-- | The ending hash key of the hash key range.
hkrEndingHashKey :: Lens' HashKeyRange Text
hkrEndingHashKey = lens _hkrEndingHashKey (\ s a -> s{_hkrEndingHashKey = a});

instance FromJSON HashKeyRange where
        parseJSON
          = withObject "HashKeyRange"
              (\ x ->
                 HashKeyRange' <$>
                   (x .: "StartingHashKey") <*> (x .: "EndingHashKey"))

-- | Represents the output for @PutRecords@.
--
-- /See:/ 'putRecordsRequestEntry' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'prreExplicitHashKey'
--
-- * 'prreData'
--
-- * 'prrePartitionKey'
data PutRecordsRequestEntry = PutRecordsRequestEntry'
    { _prreExplicitHashKey :: !(Maybe Text)
    , _prreData            :: !Base64
    , _prrePartitionKey    :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'PutRecordsRequestEntry' smart constructor.
putRecordsRequestEntry :: Base64 -> Text -> PutRecordsRequestEntry
putRecordsRequestEntry pData pPartitionKey =
    PutRecordsRequestEntry'
    { _prreExplicitHashKey = Nothing
    , _prreData = pData
    , _prrePartitionKey = pPartitionKey
    }

-- | The hash value used to determine explicitly the shard that the data
-- record is assigned to by overriding the partition key hash.
prreExplicitHashKey :: Lens' PutRecordsRequestEntry (Maybe Text)
prreExplicitHashKey = lens _prreExplicitHashKey (\ s a -> s{_prreExplicitHashKey = a});

-- | The data blob to put into the record, which is base64-encoded when the
-- blob is serialized. The maximum size of the data blob (the payload
-- before base64-encoding) is 50 kilobytes (KB)
prreData :: Lens' PutRecordsRequestEntry Base64
prreData = lens _prreData (\ s a -> s{_prreData = a});

-- | Determines which shard in the stream the data record is assigned to.
-- Partition keys are Unicode strings with a maximum length limit of 256
-- characters for each key. Amazon Kinesis uses the partition key as input
-- to a hash function that maps the partition key and associated data to a
-- specific shard. Specifically, an MD5 hash function is used to map
-- partition keys to 128-bit integer values and to map associated data
-- records to shards. As a result of this hashing mechanism, all data
-- records with the same partition key map to the same shard within the
-- stream.
prrePartitionKey :: Lens' PutRecordsRequestEntry Text
prrePartitionKey = lens _prrePartitionKey (\ s a -> s{_prrePartitionKey = a});

instance ToJSON PutRecordsRequestEntry where
        toJSON PutRecordsRequestEntry'{..}
          = object
              ["ExplicitHashKey" .= _prreExplicitHashKey,
               "Data" .= _prreData,
               "PartitionKey" .= _prrePartitionKey]

-- | Represents the result of an individual record from a @PutRecords@
-- request. A record that is successfully added to your Amazon Kinesis
-- stream includes SequenceNumber and ShardId in the result. A record that
-- fails to be added to your Amazon Kinesis stream includes ErrorCode and
-- ErrorMessage in the result.
--
-- /See:/ 'putRecordsResultEntry' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'prreSequenceNumber'
--
-- * 'prreErrorCode'
--
-- * 'prreErrorMessage'
--
-- * 'prreShardId'
data PutRecordsResultEntry = PutRecordsResultEntry'
    { _prreSequenceNumber :: !(Maybe Text)
    , _prreErrorCode      :: !(Maybe Text)
    , _prreErrorMessage   :: !(Maybe Text)
    , _prreShardId        :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'PutRecordsResultEntry' smart constructor.
putRecordsResultEntry :: PutRecordsResultEntry
putRecordsResultEntry =
    PutRecordsResultEntry'
    { _prreSequenceNumber = Nothing
    , _prreErrorCode = Nothing
    , _prreErrorMessage = Nothing
    , _prreShardId = Nothing
    }

-- | The sequence number for an individual record result.
prreSequenceNumber :: Lens' PutRecordsResultEntry (Maybe Text)
prreSequenceNumber = lens _prreSequenceNumber (\ s a -> s{_prreSequenceNumber = a});

-- | The error code for an individual record result. @ErrorCodes@ can be
-- either @ProvisionedThroughputExceededException@ or @InternalFailure@.
prreErrorCode :: Lens' PutRecordsResultEntry (Maybe Text)
prreErrorCode = lens _prreErrorCode (\ s a -> s{_prreErrorCode = a});

-- | The error message for an individual record result. An @ErrorCode@ value
-- of @ProvisionedThroughputExceededException@ has an error message that
-- includes the account ID, stream name, and shard ID. An @ErrorCode@ value
-- of @InternalFailure@ has the error message
-- @\"Internal Service Failure\"@.
prreErrorMessage :: Lens' PutRecordsResultEntry (Maybe Text)
prreErrorMessage = lens _prreErrorMessage (\ s a -> s{_prreErrorMessage = a});

-- | The shard ID for an individual record result.
prreShardId :: Lens' PutRecordsResultEntry (Maybe Text)
prreShardId = lens _prreShardId (\ s a -> s{_prreShardId = a});

instance FromJSON PutRecordsResultEntry where
        parseJSON
          = withObject "PutRecordsResultEntry"
              (\ x ->
                 PutRecordsResultEntry' <$>
                   (x .:? "SequenceNumber") <*> (x .:? "ErrorCode") <*>
                     (x .:? "ErrorMessage")
                     <*> (x .:? "ShardId"))

-- | The unit of data of the Amazon Kinesis stream, which is composed of a
-- sequence number, a partition key, and a data blob.
--
-- /See:/ 'record' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'recSequenceNumber'
--
-- * 'recData'
--
-- * 'recPartitionKey'
data Record = Record'
    { _recSequenceNumber :: !Text
    , _recData           :: !Base64
    , _recPartitionKey   :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Record' smart constructor.
record :: Text -> Base64 -> Text -> Record
record pSequenceNumber pData pPartitionKey =
    Record'
    { _recSequenceNumber = pSequenceNumber
    , _recData = pData
    , _recPartitionKey = pPartitionKey
    }

-- | The unique identifier for the record in the Amazon Kinesis stream.
recSequenceNumber :: Lens' Record Text
recSequenceNumber = lens _recSequenceNumber (\ s a -> s{_recSequenceNumber = a});

-- | The data blob. The data in the blob is both opaque and immutable to the
-- Amazon Kinesis service, which does not inspect, interpret, or change the
-- data in the blob in any way. The maximum size of the data blob (the
-- payload before base64-encoding) is 50 kilobytes (KB)
recData :: Lens' Record Base64
recData = lens _recData (\ s a -> s{_recData = a});

-- | Identifies which shard in the stream the data record is assigned to.
recPartitionKey :: Lens' Record Text
recPartitionKey = lens _recPartitionKey (\ s a -> s{_recPartitionKey = a});

instance FromJSON Record where
        parseJSON
          = withObject "Record"
              (\ x ->
                 Record' <$>
                   (x .: "SequenceNumber") <*> (x .: "Data") <*>
                     (x .: "PartitionKey"))

-- | The range of possible sequence numbers for the shard.
--
-- /See:/ 'sequenceNumberRange' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'snrEndingSequenceNumber'
--
-- * 'snrStartingSequenceNumber'
data SequenceNumberRange = SequenceNumberRange'
    { _snrEndingSequenceNumber   :: !(Maybe Text)
    , _snrStartingSequenceNumber :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'SequenceNumberRange' smart constructor.
sequenceNumberRange :: Text -> SequenceNumberRange
sequenceNumberRange pStartingSequenceNumber =
    SequenceNumberRange'
    { _snrEndingSequenceNumber = Nothing
    , _snrStartingSequenceNumber = pStartingSequenceNumber
    }

-- | The ending sequence number for the range. Shards that are in the OPEN
-- state have an ending sequence number of @null@.
snrEndingSequenceNumber :: Lens' SequenceNumberRange (Maybe Text)
snrEndingSequenceNumber = lens _snrEndingSequenceNumber (\ s a -> s{_snrEndingSequenceNumber = a});

-- | The starting sequence number for the range.
snrStartingSequenceNumber :: Lens' SequenceNumberRange Text
snrStartingSequenceNumber = lens _snrStartingSequenceNumber (\ s a -> s{_snrStartingSequenceNumber = a});

instance FromJSON SequenceNumberRange where
        parseJSON
          = withObject "SequenceNumberRange"
              (\ x ->
                 SequenceNumberRange' <$>
                   (x .:? "EndingSequenceNumber") <*>
                     (x .: "StartingSequenceNumber"))

-- | A uniquely identified group of data records in an Amazon Kinesis stream.
--
-- /See:/ 'shard' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'shaAdjacentParentShardId'
--
-- * 'shaParentShardId'
--
-- * 'shaShardId'
--
-- * 'shaHashKeyRange'
--
-- * 'shaSequenceNumberRange'
data Shard = Shard'
    { _shaAdjacentParentShardId :: !(Maybe Text)
    , _shaParentShardId         :: !(Maybe Text)
    , _shaShardId               :: !Text
    , _shaHashKeyRange          :: !HashKeyRange
    , _shaSequenceNumberRange   :: !SequenceNumberRange
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Shard' smart constructor.
shard :: Text -> HashKeyRange -> SequenceNumberRange -> Shard
shard pShardId pHashKeyRange pSequenceNumberRange =
    Shard'
    { _shaAdjacentParentShardId = Nothing
    , _shaParentShardId = Nothing
    , _shaShardId = pShardId
    , _shaHashKeyRange = pHashKeyRange
    , _shaSequenceNumberRange = pSequenceNumberRange
    }

-- | The shard Id of the shard adjacent to the shard\'s parent.
shaAdjacentParentShardId :: Lens' Shard (Maybe Text)
shaAdjacentParentShardId = lens _shaAdjacentParentShardId (\ s a -> s{_shaAdjacentParentShardId = a});

-- | The shard Id of the shard\'s parent.
shaParentShardId :: Lens' Shard (Maybe Text)
shaParentShardId = lens _shaParentShardId (\ s a -> s{_shaParentShardId = a});

-- | The unique identifier of the shard within the Amazon Kinesis stream.
shaShardId :: Lens' Shard Text
shaShardId = lens _shaShardId (\ s a -> s{_shaShardId = a});

-- | The range of possible hash key values for the shard, which is a set of
-- ordered contiguous positive integers.
shaHashKeyRange :: Lens' Shard HashKeyRange
shaHashKeyRange = lens _shaHashKeyRange (\ s a -> s{_shaHashKeyRange = a});

-- | The range of possible sequence numbers for the shard.
shaSequenceNumberRange :: Lens' Shard SequenceNumberRange
shaSequenceNumberRange = lens _shaSequenceNumberRange (\ s a -> s{_shaSequenceNumberRange = a});

instance FromJSON Shard where
        parseJSON
          = withObject "Shard"
              (\ x ->
                 Shard' <$>
                   (x .:? "AdjacentParentShardId") <*>
                     (x .:? "ParentShardId")
                     <*> (x .: "ShardId")
                     <*> (x .: "HashKeyRange")
                     <*> (x .: "SequenceNumberRange"))

-- | Represents the output for @DescribeStream@.
--
-- /See:/ 'streamDescription' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'sdStreamName'
--
-- * 'sdStreamARN'
--
-- * 'sdStreamStatus'
--
-- * 'sdShards'
--
-- * 'sdHasMoreShards'
data StreamDescription = StreamDescription'
    { _sdStreamName    :: !Text
    , _sdStreamARN     :: !Text
    , _sdStreamStatus  :: !StreamStatus
    , _sdShards        :: ![Shard]
    , _sdHasMoreShards :: !Bool
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'StreamDescription' smart constructor.
streamDescription :: Text -> Text -> StreamStatus -> Bool -> StreamDescription
streamDescription pStreamName pStreamARN pStreamStatus pHasMoreShards =
    StreamDescription'
    { _sdStreamName = pStreamName
    , _sdStreamARN = pStreamARN
    , _sdStreamStatus = pStreamStatus
    , _sdShards = mempty
    , _sdHasMoreShards = pHasMoreShards
    }

-- | The name of the stream being described.
sdStreamName :: Lens' StreamDescription Text
sdStreamName = lens _sdStreamName (\ s a -> s{_sdStreamName = a});

-- | The Amazon Resource Name (ARN) for the stream being described.
sdStreamARN :: Lens' StreamDescription Text
sdStreamARN = lens _sdStreamARN (\ s a -> s{_sdStreamARN = a});

-- | The current status of the stream being described.
--
-- The stream status is one of the following states:
--
-- -   @CREATING@ - The stream is being created. Amazon Kinesis immediately
--     returns and sets @StreamStatus@ to @CREATING@.
-- -   @DELETING@ - The stream is being deleted. The specified stream is in
--     the @DELETING@ state until Amazon Kinesis completes the deletion.
-- -   @ACTIVE@ - The stream exists and is ready for read and write
--     operations or deletion. You should perform read and write operations
--     only on an @ACTIVE@ stream.
-- -   @UPDATING@ - Shards in the stream are being merged or split. Read
--     and write operations continue to work while the stream is in the
--     @UPDATING@ state.
sdStreamStatus :: Lens' StreamDescription StreamStatus
sdStreamStatus = lens _sdStreamStatus (\ s a -> s{_sdStreamStatus = a});

-- | The shards that comprise the stream.
sdShards :: Lens' StreamDescription [Shard]
sdShards = lens _sdShards (\ s a -> s{_sdShards = a});

-- | If set to @true@, more shards in the stream are available to describe.
sdHasMoreShards :: Lens' StreamDescription Bool
sdHasMoreShards = lens _sdHasMoreShards (\ s a -> s{_sdHasMoreShards = a});

instance FromJSON StreamDescription where
        parseJSON
          = withObject "StreamDescription"
              (\ x ->
                 StreamDescription' <$>
                   (x .: "StreamName") <*> (x .: "StreamARN") <*>
                     (x .: "StreamStatus")
                     <*> (x .:? "Shards" .!= mempty)
                     <*> (x .: "HasMoreShards"))

-- | Metadata assigned to the stream, consisting of a key-value pair.
--
-- /See:/ 'tag' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'tagValue'
--
-- * 'tagKey'
data Tag = Tag'
    { _tagValue :: !(Maybe Text)
    , _tagKey   :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'Tag' smart constructor.
tag :: Text -> Tag
tag pKey =
    Tag'
    { _tagValue = Nothing
    , _tagKey = pKey
    }

-- | An optional string, typically used to describe or define the tag.
-- Maximum length: 256 characters. Valid characters: Unicode letters,
-- digits, white space, _ . \/ = + - % \@
tagValue :: Lens' Tag (Maybe Text)
tagValue = lens _tagValue (\ s a -> s{_tagValue = a});

-- | A unique identifier for the tag. Maximum length: 128 characters. Valid
-- characters: Unicode letters, digits, white space, _ . \/ = + - % \@
tagKey :: Lens' Tag Text
tagKey = lens _tagKey (\ s a -> s{_tagKey = a});

instance FromJSON Tag where
        parseJSON
          = withObject "Tag"
              (\ x -> Tag' <$> (x .:? "Value") <*> (x .: "Key"))
