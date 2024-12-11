CREATE TABLE ban (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255),
    list_id VARCHAR(255),
    PRIMARY KEY (id)
);
CREATE INDEX ix_ban_list_id ON ban (list_id);
CREATE INDEX ix_ban_email ON ban (email);

CREATE TABLE uid (
    id INT NOT NULL AUTO_INCREMENT,
    uid CHAR(32),
    PRIMARY KEY (id)
);
CREATE INDEX ix_uid_uid ON uid (uid);

CREATE TABLE preferences (
    id INT NOT NULL AUTO_INCREMENT,
    acknowledge_posts BOOLEAN,
    hide_address BOOLEAN,
    preferred_language VARCHAR(255),
    receive_list_copy BOOLEAN,
    receive_own_postings BOOLEAN,
    delivery_mode INT,
    delivery_status INT,
    PRIMARY KEY (id)
);

CREATE TABLE mailinglist (
    id INT NOT NULL AUTO_INCREMENT,
    list_name VARCHAR(255),
    mail_host VARCHAR(255),
    list_id VARCHAR(255),
    allow_list_posts BOOLEAN,
    include_rfc2369_headers BOOLEAN,
    advertised BOOLEAN,
    anonymous_list BOOLEAN,
    created_at DATETIME,
    next_request_id INT,
    next_digest_number INT,
    digest_last_sent_at DATETIME,
    volume INT,
    last_post_at DATETIME,
    accept_these_nonmembers LONGBLOB,
    admin_immed_notify BOOLEAN,
    admin_notify_mchanges BOOLEAN,
    administrivia BOOLEAN,
    archive_policy INT,
    autoresponse_grace_period DATETIME,
    autorespond_owner INT,
    autoresponse_owner_text TEXT,
    autorespond_postings INT,
    autoresponse_postings_text TEXT,
    autorespond_requests INT,
    autoresponse_request_text TEXT,
    filter_action INT,
    filter_content BOOLEAN,
    collapse_alternatives BOOLEAN,
    convert_html_to_plaintext BOOLEAN,
    bounce_info_stale_after DATETIME,
    bounce_matching_headers VARCHAR(255),
    bounce_notify_owner_on_bounce_increment BOOLEAN,
    bounce_notify_owner_on_disable BOOLEAN,
    bounce_notify_owner_on_removal BOOLEAN,
    bounce_score_threshold INT,
    bounce_you_are_disabled_warnings INT,
    bounce_you_are_disabled_warnings_interval DATETIME,
    forward_unrecognized_bounces_to INT,
    process_bounces BOOLEAN,
    dmarc_mitigate_action INT,
    dmarc_mitigate_unconditionally BOOLEAN,
    dmarc_moderation_notice VARCHAR(255),
    dmarc_wrapped_message_text VARCHAR(255),
    default_member_action INT,
    default_nonmember_action INT,
    description VARCHAR(255),
    digests_enabled BOOLEAN,
    digest_is_default BOOLEAN,
    digest_send_periodic BOOLEAN,
    digest_size_threshold FLOAT,
    digest_volume_frequency INT,
    discard_these_nonmembers LONGBLOB,
    emergency BOOLEAN,
    encode_ascii_prefixes BOOLEAN,
    first_strip_reply_to BOOLEAN,
    forward_auto_discards BOOLEAN,
    gateway_to_mail BOOLEAN,
    gateway_to_news BOOLEAN,
    hold_these_nonmembers LONGBLOB,
    info TEXT,
    linked_newsgroup VARCHAR(255),
    max_days_to_hold INT,
    max_message_size INT,
    max_num_recipients INT,
    member_moderation_notice VARCHAR(255),
    moderator_password BLOB,
    newsgroup_moderation INT,
    nntp_prefix_subject_too BOOLEAN,
    nonmember_rejection_notice VARCHAR(255),
    obscure_addresses BOOLEAN,
    owner_chain VARCHAR(255),
    owner_pipeline VARCHAR(255),
    personalize INT,
    post_id INT,
    posting_chain VARCHAR(255),
    posting_pipeline VARCHAR(255),
    preferred_language VARCHAR(255),
    display_name VARCHAR(255),
    reject_these_nonmembers LONGBLOB,
    reply_goes_to_list INT,
    reply_to_address VARCHAR(255),
    require_explicit_destination BOOLEAN,
    respond_to_post_requests BOOLEAN,
    member_roster_visibility INT,
    scrub_nondigest BOOLEAN,
    send_goodbye_message BOOLEAN,
    send_welcome_message BOOLEAN,
    subject_prefix VARCHAR(255),
    subscription_policy INT,
    topics LONGBLOB,
    topics_bodylines_limit INT,
    topics_enabled BOOLEAN,
    unsubscription_policy INT,
    usenet_watermark INT,
    archive_rendering_mode INT,
    PRIMARY KEY (id)
);
CREATE INDEX ix_mailinglist_mail_host ON mailinglist (mail_host);
CREATE INDEX ix_mailinglist_list_name ON mailinglist (list_name);
CREATE UNIQUE INDEX ix_mailinglist_list_id ON mailinglist (list_id);

CREATE TABLE pended (
    id INT NOT NULL AUTO_INCREMENT,
    token VARCHAR(255),
    expiration_date DATETIME,
    PRIMARY KEY (id)
);
CREATE INDEX ix_pended_expiration_date ON pended (expiration_date);
CREATE INDEX ix_pended_token ON pended (token);

CREATE TABLE bounceevent (
    id INT NOT NULL AUTO_INCREMENT,
    list_id VARCHAR(255),
    email VARCHAR(255),
    timestamp DATETIME,
    message_id VARCHAR(255),
    context INT,
    processed BOOLEAN,
    PRIMARY KEY (id)
);

CREATE TABLE file_cache (
    id INT NOT NULL AUTO_INCREMENT,
    `key` VARCHAR(255),
    file_id VARCHAR(255),
    is_bytes BOOLEAN,
    created_on DATETIME,
    expires_on DATETIME,
    PRIMARY KEY (id)
);

CREATE TABLE domain (
    id INT NOT NULL AUTO_INCREMENT,
    mail_host VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    alias_domain VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE message (
    id INT NOT NULL AUTO_INCREMENT,
    message_id VARCHAR(255),
    message_id_hash VARCHAR(255),
    path VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE template (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    context VARCHAR(255),
    uri VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE workflowstate (
    token VARCHAR(255) NOT NULL,
    step VARCHAR(255),
    data VARCHAR(510),
    PRIMARY KEY (token)
);

CREATE TABLE contentfilter (
    id INT NOT NULL AUTO_INCREMENT,
    mailing_list_id INT,
    filter_type INT,
    filter_pattern VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix_contentfilter_mailing_list_id ON contentfilter (mailing_list_id);

CREATE TABLE acceptablealias (
    id INT NOT NULL AUTO_INCREMENT,
    mailing_list_id INT NOT NULL,
    alias VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix_acceptablealias_mailing_list_id ON acceptablealias (mailing_list_id);
CREATE INDEX ix_acceptablealias_alias ON acceptablealias (alias);

CREATE TABLE listarchiver (
    id INT NOT NULL AUTO_INCREMENT,
    mailing_list_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    _is_enabled BOOLEAN,
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix_listarchiver_mailing_list_id ON listarchiver (mailing_list_id);

CREATE TABLE headermatch (
    id INT NOT NULL AUTO_INCREMENT,
    mailing_list_id INT NOT NULL,
    position INT,
    header VARCHAR(255),
    pattern VARCHAR(255),
    chain VARCHAR(255),
    tag VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix_headermatch_mailing_list_id ON headermatch (mailing_list_id);
CREATE INDEX ix_headermatch_position ON headermatch (position);

CREATE TABLE pendedkeyvalue (
    id INT NOT NULL AUTO_INCREMENT,
    `key` VARCHAR(255),
    value VARCHAR(255),
    pended_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (pended_id) REFERENCES pended (id)
);
CREATE INDEX ix_pendedkeyvalue_pended_id ON pendedkeyvalue (pended_id);
CREATE INDEX ix_pendedkeyvalue_value ON pendedkeyvalue (value);
CREATE INDEX ix_pendedkeyvalue_key ON pendedkeyvalue (`key`);

CREATE TABLE _request (
    id INT NOT NULL AUTO_INCREMENT,
    `key` VARCHAR(255),
    request_type INT,
    data_hash VARCHAR(255),
    mailing_list_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix__request_mailing_list_id ON _request (mailing_list_id);

CREATE TABLE address (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE,
    _original VARCHAR(255),
    display_name VARCHAR(255),
    verified_on DATETIME,
    registered_on DATETIME,
    user_id INT,
    preferences_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (preferences_id) REFERENCES preferences (id)
);
CREATE INDEX ix_address_user_id ON address (user_id);
CREATE INDEX ix_address_preferences_id ON address (preferences_id);

CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT,
    display_name VARCHAR(255),
    password VARCHAR(255),
    _user_id CHAR(32),
    _created_on DATETIME,
    is_server_owner BOOLEAN,
    _preferred_address_id INT,
    preferences_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (preferences_id) REFERENCES preferences (id)
);
CREATE INDEX ix_user_preferences_id ON user (preferences_id);
CREATE INDEX ix_user__user_id ON user (_user_id);

-- Nachträglich die Referenz hinzufügen, um die Zirkularität zu umgehen
ALTER TABLE user
ADD CONSTRAINT _preferred_address FOREIGN KEY (_preferred_address_id) REFERENCES address (id) ON DELETE SET NULL;

ALTER TABLE address
ADD FOREIGN KEY (user_id) REFERENCES user (id);


CREATE TABLE domain_owner (
    user_id INT NOT NULL,
    domain_id INT NOT NULL,
    PRIMARY KEY (user_id, domain_id),
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (domain_id) REFERENCES domain (id)
);

CREATE TABLE autoresponserecord (
    id INT NOT NULL AUTO_INCREMENT,
    address_id INT,
    mailing_list_id INT,
    response_type INT,
    date_sent DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (address_id) REFERENCES address (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id)
);
CREATE INDEX ix_autoresponserecord_address_id ON autoresponserecord (address_id);
CREATE INDEX ix_autoresponserecord_mailing_list_id ON autoresponserecord (mailing_list_id);

CREATE TABLE member (
    id INT NOT NULL AUTO_INCREMENT,
    _member_id CHAR(32),
    role INT,
    list_id VARCHAR(255),
    moderation_action INT,
    address_id INT,
    preferences_id INT,
    user_id INT,
    bounce_score INT,
    last_bounce_received DATETIME,
    last_warning_sent DATETIME,
    total_warnings_sent INT,
    PRIMARY KEY (id),
    FOREIGN KEY (address_id) REFERENCES address (id),
    FOREIGN KEY (preferences_id) REFERENCES preferences (id),
    FOREIGN KEY (user_id) REFERENCES user (id)
);
CREATE INDEX ix_member_user_id ON member (user_id);
CREATE INDEX ix_member_bounce_score ON member (bounce_score);
CREATE INDEX ix_member_role ON member (role);
CREATE INDEX ix_member_list_id ON member (list_id);
CREATE INDEX ix_member_last_warning_sent ON member (last_warning_sent);
CREATE INDEX ix_member_total_warnings_sent ON member (total_warnings_sent);
CREATE INDEX ix_member_address_id ON member (address_id);
CREATE INDEX ix_member_preferences_id ON member (preferences_id);

CREATE TABLE onelastdigest (
    id INT NOT NULL AUTO_INCREMENT,
    mailing_list_id INT,
    address_id INT,
    delivery_mode INT,
    PRIMARY KEY (id),
    FOREIGN KEY (mailing_list_id) REFERENCES mailinglist (id),
    FOREIGN KEY (address_id) REFERENCES address (id)
);

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL,
    PRIMARY KEY (version_num)
);

