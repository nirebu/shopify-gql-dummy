# frozen_string_literal: true

class Customer
  module Attributes
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Model

      attr_accessor(
        :acceptsMarketing,
        :acceptsMarketingUpdatedAt,
        :addresses,
        :amountSpent,
        :canDelete,
        :companyContactProfiles,
        :createdAt,
        :defaultAddress,
        :displayName,
        :email,
        :emailMarketingConsent,
        :firstName,
        :hasTimelineComment,
        :id,
        :image,
        :lastName,
        :lastOrder,
        :legacyResourceId,
        :lifetimeDuration,
        :locale,
        :market,
        :marketingOptInLevel,
        :mergeable,
        :metafield,
        :multipassIdentifier,
        :note,
        :numberOfOrders,
        :phone,
        :privateMetafield,
        :productSubscriberStatus,
        :smsMarketingConsent,
        :state,
        :statistics,
        :tags,
        :taxExempt,
        :taxExemptions,
        :unsubscribeUrl,
        :updatedAt,
        :validEmailAddress,
        :verifiedEmail
      )
    end
  end
end
