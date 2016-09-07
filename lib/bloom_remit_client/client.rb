# frozen_string_literal: true
module BloomRemitClient
  class Client
    include Virtus.model

    attribute :api_token, String
    attribute :api_secret, String
    attribute :agent_id, String
    # TODO: Add some ability to change connection.
    # attribute :connection, ConnectionClient, default: 'httparty'

    include ActiveModel::Validations
    validates :token, :secret, :agent_id, presence: true

    # GET
    # /api/v2/billers
    # Parameters: none
    def billers
      raw_response = Requests::Biller::List.new.()
      JSON.parse(raw_response.body)
      # BillersResponse.new(raw_response: raw_response)
    end

    # GET
    # /api/v1/partners/:api_token/credits
    # Parameters: none
    def credits(params = {})
      request_params = params.merge(access_params)
      raw_response = Requests::Credit::List.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/credits/history
    # Parameters: none
    def credits_history(params = {})
      request_params = params.merge(access_params)
      raw_response = Requests::Credit::History.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # POST
    # /api/v1/payments
    # Parameters:
    #   api_token:
    #     String, required
    #   api_secret:
    #     String, required
    #   sender_id:
    #     String, required
    #   agent_id:
    #     String, required
    #   payment:
    #     Hash, required
    #   payment[orig_currency]:
    #     One of: [PHP, USD, KRW, AUD, CAD, JPY, NZD, SGD, HKD, CNY, EUR, VND, SAR, TWD,
    #              QAR, KWD, AED, GBP, MYR, INR, IDR, BTC],
    #     required
    #   payment[paid_in_orig_currency]:
    #     Float, required
    #     Amount paid by customer (Ex. 20000.00)
    #   payment[flat_fee_in_orig_currency]:
    #     Float, optional
    #     Flat service fee that you wish to add to the total bill of your sender.
    #       Leave this blank to use your default fee (if any).
    #   payment[forex_margin]:
    #     Float, optional
    #     Additional foreign-exchange percentage to add to the total bill of your sender.
    #       Leave this blank to use your default margin (if any).
    #   payment[dest_currency]:
    #     One of: [PHP, USD, KRW, AUD, CAD, JPY, NZD, SGD, HKD, CNY, EUR, VND, SAR, TWD,
    #             QAR, KWD, AED, GBP, MYR, INR, IDR, BTC],
    #     required
    #     Currency of Destination
    #   payment[receivable_in_dest_currency]:
    #     Float, optional
    #     Amount received by recipient (Ex. 1000.00).
    #       This is computed automatically and may be left blank
    #   payment[payout_method]:
    #     One of: [BATELEC1, CDO_WATER, PRIMEWATER, DIGITEL, SUNCELLULAR, G-NET, BAYANTEL,
    #              PRC, PLDT, SMART, MANILAWATER, MAYNILAD, GLOBELINES, GHPHONE, CABLELINK,
    #              OPTIMUM_BANK, VECO, STA_LUCIA_REALTY, SUMISHO, SUBIC_ENERZONE, NORKIS,
    #              CIGNAL, UNISTAR, SKYCABLE, PILIPINO_CABLE, HM_CATV, BRIGHTMOON_CABLE,
    #              JMY_ADVANTAGE, CAVITE_CABLE, SUBURBAN_CABLE, ISLA_CABLE, TARLAC_CABLE,
    #              SORSOGON_WATER, BENECO, ILECO1, PAL, GOLDEN_HAVEN, PELCO1, COTABATO_LIGHT,
    #              AEON_CREDIT, PESOPAY, PRESCO, MAYBRIDGE, METRO_FASTBET, SKYJET, FIRST_PEAK,
    #              PLUS_CABLE, NORTHSTAR_CABLE, VERDANT_CABLE, LEISURE_WORLD, RMG, CARISSA,
    #              GLOBALLAND, CHINATRUST, MCWD, STA_MARIA_WATER, MFI_LENDING, ICONNEX,
    #              GOODHANDS_WATER, HAPPYWELL, TARELCO2, AXA_PHIL, CEBUPACIFIC, NEECO2_AREA1,
    #              COMCLARK, CENTRAL_LUZON_CABLE, PRIMECAST_CABLE, CANORECO, INEC, LAGUNAWATER,
    #              AIRASIA, BPI_CREDITCARD, ANGELES_ELECTRIC, BP_WATERWORKS, HITECH_CABLE, ROYALCABLE,
    #              HONEYCOMB, FLECO, POEA, SANCLEMENTE_CABLE, GOLDEN_EAGLE_CABLE, CALUMPIT_WATER,
    #              COCOLIFE, MABALACAT_WATER, PENELCO, VIACOM, PARAMOUNT, GLOBAL_DOMINION, MYCLOUD,
    #              INSULAR_SAVERS, ASIALINK, FINASWIDE, SOUTH_ASIALINK, CABLE_TELEVISION, CEBECO2,
    #              PAYEXPRESS, NSOHELPLINE.COM, PLANET_CABLE, PROMO_ECPROTECT, PHILSMILE, ANGELES_CABLE,
    #              PELCO2, AUB_CREDITCARDS, DAVAOLIGHT, HOME_LIPA_CABLE, TABACO_WATER, MET_CABLE,
    #              DRAGONPAY, ABS_MOBILE, HOME_CREDIT, GATE, BATELEC2, CONVERGE_ICT, RS_PROPERTY,
    #              PELCO3, NEECO2_AREA2, SITELCO],
    #     required
    #   payment[account_name]:
    #     String, required
    #     Account identifier with the biller (Ex. Phone number)
    #   payment[account_number]:
    #     String, required
    #     Account number with the biller (Ex. Customer number)
    #   payment[callback_url]:
    #     String, optional
    #     URL to post updates to when the status of a remittance changes.
    #       Please respond with a HTTP Code 200 and the word 'ok'.
    #       If you have a Callback URL already defined in the Partner Settings, this is unnecessary.
    #   payment[external_id]:
    #     String, required
    #     The ID that the bills payment service provider will track. Must be unique
    def create_payment(params)
      request_params = default_params.merge(params).merge(access_params)
      raw_response = Requests::Payment::Create.new(request_params).()
      JSON.parse(raw_response.body)
      # CreatePaymentResponse.new(raw_response: request.())
    end

    ######################## AGENT RESOURCES ########################
    # GET
    # /api/v1/partners/:api_token/agents
    # Parameters: none
    def agents(params = {})
      request_params = params.merge(access_params)
      raw_response = Requests::Agent::List.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/agents/:id
    # Parameters:
    #   id OR agent_id: String
    def agent(params = {}) # Not working: 500
      params[:agent_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Agent::Show.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # POST
    # /api/v1/partners/:api_token/agents
    # Parameters:
    #   agent:
    #     Hash, required
    #   agent[:name]:
    #     String, optional
    def create_agent(params = {}) # Creates, but respond with 500.
      request_params = params.merge(access_params)
      raw_response = Requests::Agent::Create.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # PUT
    # /api/v1/partners/:api_token/agents/:id
    # Parameters:
    #   id: or :agent_id
    #     Required
    #   agent:
    #     Hash, required
    #   agent[:name]:
    #     String, optional
    def update_agent(params = {}) # Not working.
      params[:agent_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Agent::Update.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # DELETE
    # /api/v1/partners/:api_token/agents/:id
    # Parameters: none
    def delete_agent(params = {}) # Not working.
      params[:agent_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Agent::Delete.new(request_params).()
      JSON.parse(raw_response.body)
    end
    #####################################################################

    ######################## RECIPIENT RESOURCES ########################
    # GET
    # /api/v1/partners/:api_token/senders/:sender_id/recipients
    # Parameters:
    #   sender_id: Required
    def recipients(params)
      request_params = params.merge(access_params)
      raw_response = Requests::Recipient::List.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/senders/:sender_id/recipients/:id
    # Parameters:
    #   sender_id: Required
    #   id: or recipient_id: Required
    def recipient(params)
      params[:recipient_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Recipient::Show.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # POST
    # /api/v1/partners/:api_token/senders/:sender_id/recipients
    # Parameters:
    #   sender_id:
    #     String, required
    #   recipient:
    #     Hash, required
    #   recipient[first_name]:
    #     String, required
    #   recipient[last_name]:
    #     String, required
    #   recipient[mobile]:
    #     String, required
    #   recipient[email]:
    #     String, optional
    #   recipient[address]:
    #     String, optional
    #   recipient[city]:
    #     String, optional
    #   recipient[state]:
    #     String, optional
    #   recipient[country]:
    #     One of: [AD, AE, AF, AG, AI, AL, AM, AN, AO, AQ, AR, AS, AT, AU, AW, AX, AZ,
    #              BA, BB, BD, BE, BF, BG, BH, BI, BJ, BL, BM, BN, BO, BQ, BR, BS, BT,
    #              BV, BW, BY, BZ, CA, CC, CD, CF, CG, CH, CI, CK, CL, CM, CN, CO, CR,
    #              CU, CV, CW, CX, CY, CZ, DE, DJ, DK, DM, DO, DZ, EC, EE, EG, EH, ER,
    #              ES, ET, FI, FJ, FK, FM, FO, FR, GA, GB, GD, GE, GF, GG, GH, GI, GL,
    #              GM, GN, GP, GQ, GR, GS, GT, GU, GW, GY, HK, HM, HN, HR, HT, HU, ID,
    #              IE, IL, IM, IN, IO, IQ, IR, IS, IT, JE, JM, JO, JP, KE, KG, KH, KI,
    #              KM, KN, KP, KR, KW, KY, KZ, LA, LB, LC, LI, LK, LR, LS, LT, LU, LV,
    #              LY, MA, MC, MD, ME, MF, MG, MH, MK, ML, MM, MN, MO, MP, MQ, MR, MS,
    #              MT, MU, MV, MW, MX, MY, MZ, NA, NC, NE, NF, NG, NI, NL, NO, NP, NR,
    #              NU, NZ, OM, PA, PE, PF, PG, PH, PK, PL, PM, PN, PR, PS, PT, PW, PY,
    #              QA, RE, RO, RS, RU, RW, SA, SB, SC, SD, SE, SG, SH, SI, SJ, SK, SL,
    #              SM, SN, SO, SR, SS, ST, SV, SX, SY, SZ, TC, TD, TF, TG, TH, TJ, TK,
    #              TL, TM, TN, TO, TR, TT, TV, TW, TZ, UA, UG, UM, US, UY, UZ, VA, VC,
    #              VE, VG, VI, VN, VU, WF, WS, YE, YT, ZA, ZM, ZW],
    #     optional
    #   recipient[postal_code]:
    #     String, optional
    def create_recipient(params)
      request_params = params.merge(access_params)
      raw_response = Requests::Recipient::Create.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # PUT
    # /api/v1/partners/:api_token/senders/:sender_id/recipients/:id
    # Parameters:
    #   id: or recipient_id:
    #     String, required
    #   + same params as for create.
    def update_recipient(params)
      params[:recipient_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Recipient::Update.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # DELETE
    # /api/v1/partners/:api_token/senders/:sender_id/recipients/:id
    # Parameters:
    #   id: or recipient_id:
    #     String, required
    def delete_recipient(params = {})
      params[:recipient_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Recipient::Delete.new(request_params).()
      JSON.parse(raw_response.body)
    end
    #####################################################################

    ######################## SENDER RESOURCES ########################
    # GET
    # /api/v1/partners/:api_token/senders
    # Parameters: none
    def senders(params = {})
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::List.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/senders/:id
    # Parameters:
    #   id: or sender_id: String, required
    def sender(params = {})
      params[:sender_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::Show.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/senders/find_by_email
    # Parameters:
    #   email: String, required
    def sender_by_email(params)
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::FindByEmail.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # GET
    # /api/v1/partners/:api_token/senders/find_by_mobile
    # Parameters:
    #   mobile: String, required
    def sender_by_mobile(params = {})
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::FindByMobile.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # POST
    # /api/v1/partners/:api_token/senders
    # Parameters:
    #   agent_id:
    #     String, optional
    #     The id of the Agent that this user belongs to.
    #       If you don`t include this, we will automatically assign this user
    #       to the first Agent record that belongs to this partner.
    #   sender:
    #     Hash, required
    #   sender[first_name]:
    #     String, required
    #   sender[last_name]:
    #     String, required
    #   sender[email]:
    #     String, required
    #   sender[mobile]:
    #     String, required
    #   sender[address]:
    #     String, optional
    #   sender[city]:
    #     String, optional
    #   sender[country]:
    #     String, required
    #   sender[postal_code]:
    #     String, optional
    #   sender[identification]:
    #     Hash, optional
    #   sender[identification][url]
    #     String, optional
    #     URL string pointing to a static image of the user`s passport, driver`s license,
    #       or other government-issued ID. This is required for sending limits
    #       above PhP50,000.00 (Ex. http ://aws.amazon.com/image.jpg)
    #   sender[proof_of_address]
    #     Hash, optional
    #   sender[proof_of_address][url]
    #     String, optional
    #     URL string pointing to a static image of the user's utility bill, bank statement,
    #       or other third-party-issued document with residential address prominently indicated.
    #       This is required for sending limits above PhP150,000.00 (Ex. http ://aws.amazon.com/image.jpg)
    #   sender[birthday]
    #     String, optional
    #     Birthdate. This is required for sending limits above PhP150,000.00.
    def create_sender(params)
      # request_params = params.merge(access_params)
      request_params = default_params.merge(params).merge(access_params)
      raw_response = Requests::Sender::Create.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # PUT
    # /api/v1/partners/:api_token/senders/:id
    # Parameters:
    #   id: or sender_id:
    #     String, required
    #   + same params as for create.
    def update_sender(params)
      params[:sender_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::Update.new(request_params).()
      JSON.parse(raw_response.body)
    end

    # DELETE
    # /api/v1/partners/:api_token/senders/:id
    # Parameters:
    #   id: or sender_id:
    #     String, required
    def delete_sender(params = {})
      params[:sender_id] ||= params.delete(:id)
      request_params = params.merge(access_params)
      raw_response = Requests::Sender::Delete.new(request_params).()
      JSON.parse(raw_response.body)
    end
    #####################################################################

    private

    # Should overwrite any other `:api_token`, `:api_secret`
    def access_params
      @access_params ||= attributes.slice(:api_token, :api_secret)
    end

    def default_params
      @default_params ||= attributes.slice(:agent_id)
    end

    def default_headers
      @default_headers ||= {'Content-Type' => 'application/json;charset=UTF-8', 'Accept' => 'application/json'}
    end
  end
end
