{-# LANGUAGE DeriveDataTypeable          #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE StandaloneDeriving          #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.CloudWatch.V2010_08_01.Types
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Amazon CloudWatch is a monitoring service for AWS cloud resources and the
-- applications you run on AWS. You can use Amazon CloudWatch to collect and
-- track metrics, collect and monitor log files, and set alarms. Amazon
-- CloudWatch can monitor AWS resources such as Amazon EC2 instances, Amazon
-- DynamoDB tables, and Amazon RDS DB instances, as well as custom metrics
-- generated by your applications and services, and any log files your
-- applications generate. You can use Amazon CloudWatch to gain system-wide
-- visibility into resource utilization, application performance, and
-- operational health. You can use these insights to react and keep your
-- application running smoothly.
module Network.AWS.CloudWatch.V2010_08_01.Types where

import Network.AWS.Prelude
import Network.AWS.Signing.V4

-- | Supported version (@2010-08-01@) of the
-- @Amazon CloudWatch@ service.
data CloudWatch deriving (Typeable)

instance AWSService CloudWatch where
    type Sg CloudWatch = V4
    data Er CloudWatch
        = CloudWatchClient HttpException
        | CloudWatchSerializer String
        | CloudWatchService String
        | InternalServiceFault
            { _isfMessage :: Maybe Text
            }
        | InvalidFormatFault
            { _iffMessage :: Maybe Text
            }
        | InvalidNextToken
            { _intMessage :: Maybe Text
            }
        | InvalidParameterCombinationException
            { _ipceMessage :: Maybe Text
            }
        | InvalidParameterValueException
            { _ipveMessage :: Maybe Text
            }
        | LimitExceededFault
            { _lefMessage :: Maybe Text
            }
        | MissingRequiredParameterException
            { _mrpeMessage :: Maybe Text
            }
        | ResourceNotFound
            { _rnfMessage :: Maybe Text
            }

    service = Service'
        { _svcEndpoint = Regional
        , _svcPrefix   = "monitoring"
        , _svcVersion  = "2010-08-01"
        , _svcTarget   = Nothing
        }

deriving instance Show    (Er CloudWatch)
deriving instance Generic (Er CloudWatch)

instance AWSError (Er CloudWatch) where
    awsError = const "CloudWatchError"

instance AWSServiceError (Er CloudWatch) where
    serviceError    = CloudWatchService
    clientError     = CloudWatchClient
    serializerError = CloudWatchSerializer

instance Exception (Er CloudWatch)

xmlOptions :: Tagged a XMLOptions
xmlOptions = Tagged def
    { xmlNamespace = Just "http://monitoring.amazonaws.com/doc/2010-08-01/"
    }

-- | The arithmetic operation to use when comparing the specified Statistic and
-- Threshold. The specified Statistic value is used as the first operand.
data ComparisonOperator
    = ComparisonOperatorGreaterThanOrEqualToThreshold -- ^ GreaterThanOrEqualToThreshold
    | ComparisonOperatorGreaterThanThreshold -- ^ GreaterThanThreshold
    | ComparisonOperatorLessThanOrEqualToThreshold -- ^ LessThanOrEqualToThreshold
    | ComparisonOperatorLessThanThreshold -- ^ LessThanThreshold
      deriving (Eq, Show, Generic)

instance Hashable ComparisonOperator

instance FromText ComparisonOperator where
    parser = match "GreaterThanOrEqualToThreshold" ComparisonOperatorGreaterThanOrEqualToThreshold
         <|> match "GreaterThanThreshold" ComparisonOperatorGreaterThanThreshold
         <|> match "LessThanOrEqualToThreshold" ComparisonOperatorLessThanOrEqualToThreshold
         <|> match "LessThanThreshold" ComparisonOperatorLessThanThreshold

instance ToText ComparisonOperator where
    toText ComparisonOperatorGreaterThanOrEqualToThreshold = "GreaterThanOrEqualToThreshold"
    toText ComparisonOperatorGreaterThanThreshold = "GreaterThanThreshold"
    toText ComparisonOperatorLessThanOrEqualToThreshold = "LessThanOrEqualToThreshold"
    toText ComparisonOperatorLessThanThreshold = "LessThanThreshold"

instance ToByteString ComparisonOperator

instance FromXML ComparisonOperator where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "ComparisonOperator"

instance ToQuery ComparisonOperator where
    toQuery = genericQuery def

-- | The type of alarm histories to retrieve.
data HistoryItemType
    = HistoryItemTypeAction -- ^ Action
    | HistoryItemTypeConfigurationUpdate -- ^ ConfigurationUpdate
    | HistoryItemTypeStateUpdate -- ^ StateUpdate
      deriving (Eq, Show, Generic)

instance Hashable HistoryItemType

instance FromText HistoryItemType where
    parser = match "Action" HistoryItemTypeAction
         <|> match "ConfigurationUpdate" HistoryItemTypeConfigurationUpdate
         <|> match "StateUpdate" HistoryItemTypeStateUpdate

instance ToText HistoryItemType where
    toText HistoryItemTypeAction = "Action"
    toText HistoryItemTypeConfigurationUpdate = "ConfigurationUpdate"
    toText HistoryItemTypeStateUpdate = "StateUpdate"

instance ToByteString HistoryItemType

instance FromXML HistoryItemType where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "HistoryItemType"

instance ToQuery HistoryItemType where
    toQuery = genericQuery def

-- | The unit of the metric.
data StandardUnit
    = StandardUnitBits -- ^ Bits
    | StandardUnitBitsSecond -- ^ Bits/Second
    | StandardUnitBytes -- ^ Bytes
    | StandardUnitBytesSecond -- ^ Bytes/Second
    | StandardUnitCount -- ^ Count
    | StandardUnitCountSecond -- ^ Count/Second
    | StandardUnitGigabits -- ^ Gigabits
    | StandardUnitGigabitsSecond -- ^ Gigabits/Second
    | StandardUnitGigabytes -- ^ Gigabytes
    | StandardUnitGigabytesSecond -- ^ Gigabytes/Second
    | StandardUnitKilobits -- ^ Kilobits
    | StandardUnitKilobitsSecond -- ^ Kilobits/Second
    | StandardUnitKilobytes -- ^ Kilobytes
    | StandardUnitKilobytesSecond -- ^ Kilobytes/Second
    | StandardUnitMegabits -- ^ Megabits
    | StandardUnitMegabitsSecond -- ^ Megabits/Second
    | StandardUnitMegabytes -- ^ Megabytes
    | StandardUnitMegabytesSecond -- ^ Megabytes/Second
    | StandardUnitMicroseconds -- ^ Microseconds
    | StandardUnitMilliseconds -- ^ Milliseconds
    | StandardUnitNone -- ^ None
    | StandardUnitPercent -- ^ Percent
    | StandardUnitSeconds -- ^ Seconds
    | StandardUnitTerabits -- ^ Terabits
    | StandardUnitTerabitsSecond -- ^ Terabits/Second
    | StandardUnitTerabytes -- ^ Terabytes
    | StandardUnitTerabytesSecond -- ^ Terabytes/Second
      deriving (Eq, Show, Generic)

instance Hashable StandardUnit

instance FromText StandardUnit where
    parser = match "Bits" StandardUnitBits
         <|> match "Bits/Second" StandardUnitBitsSecond
         <|> match "Bytes" StandardUnitBytes
         <|> match "Bytes/Second" StandardUnitBytesSecond
         <|> match "Count" StandardUnitCount
         <|> match "Count/Second" StandardUnitCountSecond
         <|> match "Gigabits" StandardUnitGigabits
         <|> match "Gigabits/Second" StandardUnitGigabitsSecond
         <|> match "Gigabytes" StandardUnitGigabytes
         <|> match "Gigabytes/Second" StandardUnitGigabytesSecond
         <|> match "Kilobits" StandardUnitKilobits
         <|> match "Kilobits/Second" StandardUnitKilobitsSecond
         <|> match "Kilobytes" StandardUnitKilobytes
         <|> match "Kilobytes/Second" StandardUnitKilobytesSecond
         <|> match "Megabits" StandardUnitMegabits
         <|> match "Megabits/Second" StandardUnitMegabitsSecond
         <|> match "Megabytes" StandardUnitMegabytes
         <|> match "Megabytes/Second" StandardUnitMegabytesSecond
         <|> match "Microseconds" StandardUnitMicroseconds
         <|> match "Milliseconds" StandardUnitMilliseconds
         <|> match "None" StandardUnitNone
         <|> match "Percent" StandardUnitPercent
         <|> match "Seconds" StandardUnitSeconds
         <|> match "Terabits" StandardUnitTerabits
         <|> match "Terabits/Second" StandardUnitTerabitsSecond
         <|> match "Terabytes" StandardUnitTerabytes
         <|> match "Terabytes/Second" StandardUnitTerabytesSecond

instance ToText StandardUnit where
    toText StandardUnitBits = "Bits"
    toText StandardUnitBitsSecond = "Bits/Second"
    toText StandardUnitBytes = "Bytes"
    toText StandardUnitBytesSecond = "Bytes/Second"
    toText StandardUnitCount = "Count"
    toText StandardUnitCountSecond = "Count/Second"
    toText StandardUnitGigabits = "Gigabits"
    toText StandardUnitGigabitsSecond = "Gigabits/Second"
    toText StandardUnitGigabytes = "Gigabytes"
    toText StandardUnitGigabytesSecond = "Gigabytes/Second"
    toText StandardUnitKilobits = "Kilobits"
    toText StandardUnitKilobitsSecond = "Kilobits/Second"
    toText StandardUnitKilobytes = "Kilobytes"
    toText StandardUnitKilobytesSecond = "Kilobytes/Second"
    toText StandardUnitMegabits = "Megabits"
    toText StandardUnitMegabitsSecond = "Megabits/Second"
    toText StandardUnitMegabytes = "Megabytes"
    toText StandardUnitMegabytesSecond = "Megabytes/Second"
    toText StandardUnitMicroseconds = "Microseconds"
    toText StandardUnitMilliseconds = "Milliseconds"
    toText StandardUnitNone = "None"
    toText StandardUnitPercent = "Percent"
    toText StandardUnitSeconds = "Seconds"
    toText StandardUnitTerabits = "Terabits"
    toText StandardUnitTerabitsSecond = "Terabits/Second"
    toText StandardUnitTerabytes = "Terabytes"
    toText StandardUnitTerabytesSecond = "Terabytes/Second"

instance ToByteString StandardUnit

instance FromXML StandardUnit where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "StandardUnit"

instance ToQuery StandardUnit where
    toQuery = genericQuery def

-- | The state value to be used in matching alarms.
data StateValue
    = StateValueAlarm -- ^ ALARM
    | StateValueInsufficientData -- ^ INSUFFICIENT_DATA
    | StateValueOk -- ^ OK
      deriving (Eq, Show, Generic)

instance Hashable StateValue

instance FromText StateValue where
    parser = match "ALARM" StateValueAlarm
         <|> match "INSUFFICIENT_DATA" StateValueInsufficientData
         <|> match "OK" StateValueOk

instance ToText StateValue where
    toText StateValueAlarm = "ALARM"
    toText StateValueInsufficientData = "INSUFFICIENT_DATA"
    toText StateValueOk = "OK"

instance ToByteString StateValue

instance FromXML StateValue where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "StateValue"

instance ToQuery StateValue where
    toQuery = genericQuery def

-- | The statistic to apply to the alarm's associated metric.
data Statistic
    = StatisticAverage -- ^ Average
    | StatisticMaximum -- ^ Maximum
    | StatisticMinimum -- ^ Minimum
    | StatisticSampleCount -- ^ SampleCount
    | StatisticSum -- ^ Sum
      deriving (Eq, Show, Generic)

instance Hashable Statistic

instance FromText Statistic where
    parser = match "Average" StatisticAverage
         <|> match "Maximum" StatisticMaximum
         <|> match "Minimum" StatisticMinimum
         <|> match "SampleCount" StatisticSampleCount
         <|> match "Sum" StatisticSum

instance ToText Statistic where
    toText StatisticAverage = "Average"
    toText StatisticMaximum = "Maximum"
    toText StatisticMinimum = "Minimum"
    toText StatisticSampleCount = "SampleCount"
    toText StatisticSum = "Sum"

instance ToByteString Statistic

instance FromXML Statistic where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Statistic"

instance ToQuery Statistic where
    toQuery = genericQuery def

-- | The AlarmHistoryItem data type contains descriptive information about the
-- history of a specific alarm. If you call DescribeAlarmHistory, Amazon
-- CloudWatch returns this data type as part of the DescribeAlarmHistoryResult
-- data type.
data AlarmHistoryItem = AlarmHistoryItem
    { _ahjAlarmName :: Maybe Text
      -- ^ The descriptive name for the alarm.
    , _ahjHistoryItemType :: Maybe HistoryItemType
      -- ^ The type of alarm history item.
    , _ahjHistoryData :: Maybe Text
      -- ^ Machine-readable data about the alarm in JSON format.
    , _ahjHistorySummary :: Maybe Text
      -- ^ A human-readable summary of the alarm history.
    , _ahjTimestamp :: Maybe ISO8601
      -- ^ The time stamp for the alarm history item.
    } deriving (Show, Generic)

instance FromXML AlarmHistoryItem where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "AlarmHistoryItem"

-- | The Datapoint data type encapsulates the statistical data that Amazon
-- CloudWatch computes from metric data.
data Datapoint = Datapoint
    { _dtSampleCount :: Maybe Double
      -- ^ The number of metric values that contributed to the aggregate
      -- value of this datapoint.
    , _dtMaximum :: Maybe Double
      -- ^ The maximum of the metric value used for the datapoint.
    , _dtAverage :: Maybe Double
      -- ^ The average of metric values that correspond to the datapoint.
    , _dtMinimum :: Maybe Double
      -- ^ The minimum metric value used for the datapoint.
    , _dtSum :: Maybe Double
      -- ^ The sum of metric values used for the datapoint.
    , _dtUnit :: Maybe StandardUnit
      -- ^ The standard unit used for the datapoint.
    , _dtTimestamp :: Maybe ISO8601
      -- ^ The time stamp used for the datapoint.
    } deriving (Show, Generic)

instance FromXML Datapoint where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Datapoint"

-- | The Dimension data type further expands on the identity of a metric using a
-- Name, Value pair.
data Dimension = Dimension
    { _eValue :: Text
      -- ^ The value representing the dimension measurement.
    , _eName :: Text
      -- ^ The name of the dimension.
    } deriving (Show, Generic)

instance FromXML Dimension where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Dimension"

instance ToQuery Dimension where
    toQuery = genericQuery def

-- | The DimensionFilter data type is used to filter ListMetrics results.
data DimensionFilter = DimensionFilter
    { _dgValue :: Maybe Text
      -- ^ The value of the dimension to be matched. Specifying a Name
      -- without specifying a Value returns all values associated with
      -- that Name.
    , _dgName :: Text
      -- ^ The dimension name to be matched.
    } deriving (Show, Generic)

instance ToQuery DimensionFilter where
    toQuery = genericQuery def

-- | The Metric data type contains information about a specific metric. If you
-- call ListMetrics, Amazon CloudWatch returns information contained by this
-- data type.
data Metric = Metric
    { _rMetricName :: Maybe Text
      -- ^ The name of the metric.
    , _rNamespace :: Maybe Text
      -- ^ The namespace of the metric.
    , _rDimensions :: [Dimension]
      -- ^ A list of dimensions associated with the metric.
    } deriving (Show, Generic)

instance FromXML Metric where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "Metric"

-- | The MetricAlarm data type represents an alarm. You can use PutMetricAlarm
-- to create or update an alarm.
data MetricAlarm = MetricAlarm
    { _mbAlarmName :: Maybe Text
      -- ^ The name of the alarm.
    , _mbStateUpdatedTimestamp :: Maybe ISO8601
      -- ^ The time stamp of the last update to the alarm's state.
    , _mbPeriod :: Maybe Integer
      -- ^ The period in seconds over which the statistic is applied.
    , _mbAlarmDescription :: Maybe Text
      -- ^ The description for the alarm.
    , _mbEvaluationPeriods :: Maybe Integer
      -- ^ The number of periods over which data is compared to the
      -- specified threshold.
    , _mbMetricName :: Maybe Text
      -- ^ The name of the alarm's metric.
    , _mbNamespace :: Maybe Text
      -- ^ The namespace of alarm's associated metric.
    , _mbComparisonOperator :: Maybe ComparisonOperator
      -- ^ The arithmetic operation to use when comparing the specified
      -- Statistic and Threshold. The specified Statistic value is used as
      -- the first operand.
    , _mbOKActions :: [Text]
      -- ^ The list of actions to execute when this alarm transitions into
      -- an OK state from any other state. Each action is specified as an
      -- Amazon Resource Number (ARN). Currently the only actions
      -- supported are publishing to an Amazon SNS topic and triggering an
      -- Auto Scaling policy.
    , _mbStateValue :: Maybe StateValue
      -- ^ The state value for the alarm.
    , _mbThreshold :: Maybe Double
      -- ^ The value against which the specified statistic is compared.
    , _mbAlarmConfigurationUpdatedTimestamp :: Maybe ISO8601
      -- ^ The time stamp of the last update to the alarm configuration.
    , _mbActionsEnabled :: Maybe Bool
      -- ^ Indicates whether actions should be executed during any changes
      -- to the alarm's state.
    , _mbInsufficientDataActions :: [Text]
      -- ^ The list of actions to execute when this alarm transitions into
      -- an INSUFFICIENT_DATA state from any other state. Each action is
      -- specified as an Amazon Resource Number (ARN). Currently the only
      -- actions supported are publishing to an Amazon SNS topic or
      -- triggering an Auto Scaling policy.
    , _mbStateReason :: Maybe Text
      -- ^ A human-readable explanation for the alarm's state.
    , _mbStateReasonData :: Maybe Text
      -- ^ An explanation for the alarm's state in machine-readable JSON
      -- format.
    , _mbDimensions :: [Dimension]
      -- ^ The list of dimensions associated with the alarm's associated
      -- metric.
    , _mbAlarmArn :: Maybe Text
      -- ^ The Amazon Resource Name (ARN) of the alarm.
    , _mbAlarmActions :: [Text]
      -- ^ The list of actions to execute when this alarm transitions into
      -- an ALARM state from any other state. Each action is specified as
      -- an Amazon Resource Number (ARN). Currently the only actions
      -- supported are publishing to an Amazon SNS topic and triggering an
      -- Auto Scaling policy.
    , _mbUnit :: Maybe StandardUnit
      -- ^ The unit of the alarm's associated metric.
    , _mbStatistic :: Maybe Statistic
      -- ^ The statistic to apply to the alarm's associated metric.
    } deriving (Show, Generic)

instance FromXML MetricAlarm where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "MetricAlarm"

-- | The MetricDatum data type encapsulates the information sent with
-- PutMetricData to either create a new metric or add new values to be
-- aggregated into an existing metric.
data MetricDatum = MetricDatum
    { _meMetricName :: Text
      -- ^ The name of the metric.
    , _meValue :: Maybe Double
      -- ^ The value for the metric. Although the Value parameter accepts
      -- numbers of type Double, Amazon CloudWatch truncates values with
      -- very large exponents. Values with base-10 exponents greater than
      -- 126 (1 x 10^126) are truncated. Likewise, values with base-10
      -- exponents less than -130 (1 x 10^-130) are also truncated.
    , _meDimensions :: [Dimension]
      -- ^ A list of dimensions associated with the metric.
    , _meUnit :: Maybe StandardUnit
      -- ^ The unit of the metric.
    , _meTimestamp :: Maybe ISO8601
      -- ^ The time stamp used for the metric. If not specified, the default
      -- value is set to the time the metric data was received.
    , _meStatisticValues :: Maybe StatisticSet
      -- ^ A set of statistical values describing the metric.
    } deriving (Show, Generic)

instance ToQuery MetricDatum where
    toQuery = genericQuery def

-- | A set of statistical values describing the metric.
data StatisticSet = StatisticSet
    { _ssSampleCount :: Double
      -- ^ The number of samples used for the statistic set.
    , _ssMaximum :: Double
      -- ^ The maximum value of the sample set.
    , _ssMinimum :: Double
      -- ^ The minimum value of the sample set.
    , _ssSum :: Double
      -- ^ The sum of values for the sample set.
    } deriving (Show, Generic)

instance FromXML StatisticSet where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "StatisticSet"

instance ToQuery StatisticSet where
    toQuery = genericQuery def

-- Newtypes

-- Products
makeLenses ''AlarmHistoryItem
makeLenses ''Datapoint
makeLenses ''Dimension
makeLenses ''DimensionFilter
makeLenses ''Metric
makeLenses ''MetricAlarm
makeLenses ''MetricDatum
makeLenses ''StatisticSet
