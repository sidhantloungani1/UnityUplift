// To parse this JSON data, do
//
//     final stripePaymentModel = stripePaymentModelFromJson(jsonString);

import 'dart:convert';

StripePaymentModel stripePaymentModelFromJson(String str) => StripePaymentModel.fromJson(json.decode(str));

String stripePaymentModelToJson(StripePaymentModel data) => json.encode(data.toJson());

class StripePaymentModel {
    String? id;
    String? object;
    int? amount;
    int? amountCapturable;
    AmountDetails? amountDetails;
    int? amountReceived;
    dynamic application;
    dynamic applicationFeeAmount;
    dynamic automaticPaymentMethods;
    dynamic canceledAt;
    dynamic cancellationReason;
    String? captureMethod;
    String? clientSecret;
    String? confirmationMethod;
    int? created;
    String? currency;
    dynamic customer;
    dynamic description;
    dynamic invoice;
    dynamic lastPaymentError;
    dynamic latestCharge;
    bool? livemode;
    Metadata? metadata;
    dynamic nextAction;
    dynamic onBehalfOf;
    dynamic paymentMethod;
    dynamic paymentMethodConfigurationDetails;
    PaymentMethodOptions? paymentMethodOptions;
    List<String>? paymentMethodTypes;
    dynamic processing;
    dynamic receiptEmail;
    dynamic review;
    dynamic setupFutureUsage;
    dynamic shipping;
    dynamic source;
    dynamic statementDescriptor;
    dynamic statementDescriptorSuffix;
    String? status;
    dynamic transferData;
    dynamic transferGroup;

    StripePaymentModel({
        this.id,
        this.object,
        this.amount,
        this.amountCapturable,
        this.amountDetails,
        this.amountReceived,
        this.application,
        this.applicationFeeAmount,
        this.automaticPaymentMethods,
        this.canceledAt,
        this.cancellationReason,
        this.captureMethod,
        this.clientSecret,
        this.confirmationMethod,
        this.created,
        this.currency,
        this.customer,
        this.description,
        this.invoice,
        this.lastPaymentError,
        this.latestCharge,
        this.livemode,
        this.metadata,
        this.nextAction,
        this.onBehalfOf,
        this.paymentMethod,
        this.paymentMethodConfigurationDetails,
        this.paymentMethodOptions,
        this.paymentMethodTypes,
        this.processing,
        this.receiptEmail,
        this.review,
        this.setupFutureUsage,
        this.shipping,
        this.source,
        this.statementDescriptor,
        this.statementDescriptorSuffix,
        this.status,
        this.transferData,
        this.transferGroup,
    });

    factory StripePaymentModel.fromJson(Map<String, dynamic> json) => StripePaymentModel(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountDetails: json["amount_details"] == null ? null : AmountDetails.fromJson(json["amount_details"]),
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        automaticPaymentMethods: json["automatic_payment_methods"],
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        latestCharge: json["latest_charge"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodConfigurationDetails: json["payment_method_configuration_details"],
        paymentMethodOptions: json["payment_method_options"] == null ? null : PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: json["payment_method_types"] == null ? [] : List<String>.from(json["payment_method_types"]!.map((x) => x)),
        processing: json["processing"],
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_details": amountDetails?.toJson(),
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "automatic_payment_methods": automaticPaymentMethods,
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "latest_charge": latestCharge,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_configuration_details": paymentMethodConfigurationDetails,
        "payment_method_options": paymentMethodOptions?.toJson(),
        "payment_method_types": paymentMethodTypes == null ? [] : List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
        "processing": processing,
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
    };
}

class AmountDetails {
    Metadata? tip;

    AmountDetails({
        this.tip,
    });

    factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        tip: json["tip"] == null ? null : Metadata.fromJson(json["tip"]),
    );

    Map<String, dynamic> toJson() => {
        "tip": tip?.toJson(),
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}

class PaymentMethodOptions {
    Card? card;

    PaymentMethodOptions({
        this.card,
    });

    factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
    );

    Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
    };
}

class Card {
    dynamic installments;
    dynamic mandateOptions;
    dynamic network;
    String? requestThreeDSecure;

    Card({
        this.installments,
        this.mandateOptions,
        this.network,
        this.requestThreeDSecure,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        installments: json["installments"],
        mandateOptions: json["mandate_options"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
    );

    Map<String, dynamic> toJson() => {
        "installments": installments,
        "mandate_options": mandateOptions,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
    };
}
