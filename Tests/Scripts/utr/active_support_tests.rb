﻿class UnitTestSetup  
  def initialize
    @name = "ActiveSupport"
    super
  end
  
  def gather_files
    gather_rails_files
  end
  
  def require_files
    require 'rubygems'
    gem 'test-unit', "= #{TestUnitVersion}"
    gem 'activesupport', "= #{RailsVersion}"
    require 'active_support/version'
  end

  def sanity
    # Do some sanity checks
    sanity_size(65)
    sanity_version(RailsVersion, ActiveSupport::VERSION::STRING)
  end

  def disable_mri_failures
    disable_by_name %w{
      test_atomic_write_preserves_default_file_permissions(AtomicWriteTest)
      test_atomic_write_preserves_file_permissions(AtomicWriteTest)
      test_buffer_multibyte(BufferedLoggerTest)
      test_should_create_the_log_directory_if_it_doesnt_exist(BufferedLoggerTest)
      test_xmlschema(DateExtCalculationsTest)
      test_yesterday_constructor_when_zone_default_is_set(DateExtCalculationsTest)
      test_current_returns_date_today_when_zone_default_not_set(DateTimeExtCalculationsTest)
      test_current_returns_time_zone_today_when_zone_default_set(DateTimeExtCalculationsTest)
      test_local_offset(DateTimeExtCalculationsTest)
      test_adding_hours_across_dst_boundary(DurationTest)
      test_since_and_ago_anchored_to_time_zone_now_when_time_zone_default_set(DurationTest)
      test_crazy_key_characters(FileStoreTest)
      test_decrement(FileStoreTest)
      test_increment(FileStoreTest)
      test_local_cache_of_decrement(FileStoreTest)
      test_local_cache_of_increment(FileStoreTest)
      test_silence_stderr(KernelTest)
      test_uniq_load_paths(LoadPathsTest)
      test_center_should_count_characters_instead_of_bytes(MultibyteCharsUTF8BehaviourTest)
      test_ljust_should_count_characters_instead_of_bytes(MultibyteCharsUTF8BehaviourTest)
      test_rjust_should_count_characters_instead_of_bytes(MultibyteCharsUTF8BehaviourTest)
      test_time_to_json_includes_local_offset(TestJSONEncoding)
      test_daylight_savings_time_crossings_backward_end(TimeExtCalculationsTest)
      test_daylight_savings_time_crossings_backward_start(TimeExtCalculationsTest)
      test_daylight_savings_time_crossings_forward_end(TimeExtCalculationsTest)
      test_daylight_savings_time_crossings_forward_start(TimeExtCalculationsTest)
      test_formatted_offset_with_local(TimeExtCalculationsTest)
      test_future_with_time_current_as_time_local(TimeExtCalculationsTest)
      test_future_with_time_current_as_time_with_zone(TimeExtCalculationsTest)
      test_past_with_time_current_as_time_local(TimeExtCalculationsTest)
      test_past_with_time_current_as_time_with_zone(TimeExtCalculationsTest)
      test_seconds_since_midnight_at_daylight_savings_time_end(TimeExtCalculationsTest)
      test_seconds_since_midnight_at_daylight_savings_time_start(TimeExtCalculationsTest)
      test_time_created_with_local_constructor_cannot_represent_times_during_hour_skipped_by_dst(TimeExtCalculationsTest)
      test_to_s(TimeExtCalculationsTest)
      test_current_returns_time_zone_now_when_zone_default_set(TimeWithZoneMethodsForTimeAndDateTimeTest)
      test_in_time_zone_with_time_local_instance(TimeWithZoneMethodsForTimeAndDateTimeTest)
      test_future_with_time_current_as_time_local(TimeWithZoneTest)
      test_past_with_time_current_as_time_local(TimeWithZoneTest)
      test_now(TimeZoneTest)
      test_now_enforces_spring_dst_rules(TimeZoneTest)
      test_current_returns_time_zone_today_when_zone_default_set(DateExtCalculationsTest)
    }
  end
  
  def disable_tests
    # regex encodings
    disable_by_name %w{
      test_slice_should_take_character_offsets(MultibyteCharsUTF8BehaviourTest)
      test_transliterate_should_allow_a_custom_replacement_char(TransliterateTest)
    }

    # most failures are due to missing String#encode, String#each_char and Time#nsec
    disable_by_name %w{
      default_test(ArrayUniqByTests)
      test_uniq_by(ArrayUniqByTests)
      test_uniq_by!(ArrayUniqByTests)
      test_array_of_expressions_identify_failure(AssertDifferenceTest)
      test_array_of_expressions_identify_failure_when_message_provided(AssertDifferenceTest)
      test_compare_with_time(DateTimeExtCalculationsTest)
      test_compare_with_time_with_zone(DateTimeExtCalculationsTest)
      test_current_with_time_zone(DateTimeExtCalculationsTest)
      test_current_without_time_zone(DateTimeExtCalculationsTest)
      test_array_as_cache_key(FileStoreTest)
      test_cache_key(FileStoreTest)
      test_clear_also_clears_local_cache(FileStoreTest)
      test_delete(FileStoreTest)
      test_delete_matched(FileStoreTest)
      test_deprecated_expires_in_on_read(FileStoreTest)
      test_exist(FileStoreTest)
      test_expires_in(FileStoreTest)
      test_fetch_with_cache_miss(FileStoreTest)
      test_fetch_with_cached_nil(FileStoreTest)
      test_fetch_with_forced_cache_miss(FileStoreTest)
      test_fetch_without_cache_miss(FileStoreTest)
      test_hash_as_cache_key(FileStoreTest)
      test_keys_are_case_sensitive(FileStoreTest)
      test_local_cache_of_delete(FileStoreTest)
      test_local_cache_of_exist(FileStoreTest)
      test_local_cache_of_read(FileStoreTest)
      test_local_cache_of_write(FileStoreTest)
      test_local_cache_of_write_nil(FileStoreTest)
      test_local_writes_are_persistent_on_the_remote_cache(FileStoreTest)
      test_middleware(FileStoreTest)
      test_nil_exist(FileStoreTest)
      test_original_store_objects_should_not_be_immutable(FileStoreTest)
      test_param_as_cache_key(FileStoreTest)
      test_race_condition_protection(FileStoreTest)
      test_race_condition_protection_is_limited(FileStoreTest)
      test_race_condition_protection_is_safe(FileStoreTest)
      test_read_and_write_compressed_large_data(FileStoreTest)
      test_read_and_write_compressed_nil(FileStoreTest)
      test_read_and_write_compressed_small_data(FileStoreTest)
      test_read_multi(FileStoreTest)
      test_read_multi(FileStoreTest)
      test_really_long_keys(FileStoreTest)
      test_really_long_keys(FileStoreTest)
      test_should_overwrite(FileStoreTest)
      test_should_overwrite(FileStoreTest)
      test_should_read_and_write_hash(FileStoreTest)
      test_should_read_and_write_integer(FileStoreTest)
      test_should_read_and_write_nil(FileStoreTest)
      test_should_read_and_write_strings(FileStoreTest)
      test_store_objects_should_be_immutable(FileStoreTest)
      test_symbolize_keys_preserves_fixnum_keys(HashExtTest)
      test_symbolize_keys_preserves_fixnum_keys_for_hash_with_indifferent_access(HashExtTest)
      test_camelize_with_lower_downcases_the_first_letter(InflectorTest)
      test_parameterize_and_normalize(InflectorTest)
      test_symbol_to_lower_camel(InflectorTest)
      test_underscore_to_lower_camel(InflectorTest)
      test_silence_stderr_with_return_value(KernelTest)
      test_read_and_write_compressed_large_data(MemoryStoreTest)
      test_titleize_should_be_unicode_aware(MultibyteCharsExtrasTest)
      test_titleize_should_not_affect_characters_that_do_not_case_fold(MultibyteCharsExtrasTest)
      test_indexed_insert_accepts_fixnums(MultibyteCharsUTF8BehaviourTest)
      test_indexed_insert_should_take_character_offsets(MultibyteCharsUTF8BehaviourTest)
      test_insert_throws_index_error(MultibyteCharsUTF8BehaviourTest)
      test_rindex_should_return_character_offset(MultibyteCharsUTF8BehaviourTest)
      test_rstrip_bang_should_return_self(MultibyteCharsUTF8BehaviourTest)
      test_rstrip_strips_whitespace_from_the_right_of_the_string(MultibyteCharsUTF8BehaviourTest)
      test_should_return_character_offset_for_regexp_matches(MultibyteCharsUTF8BehaviourTest)
      test_strip_bang_should_return_self(MultibyteCharsUTF8BehaviourTest)
      test_strip_strips_whitespace(MultibyteCharsUTF8BehaviourTest)
      test_stripping_whitespace_leaves_whitespace_within_the_string_intact(MultibyteCharsUTF8BehaviourTest)
      test_valid_character_returns_an_expression_for_the_current_encoding(MultibyteUtilsTest)
      test_verify!_raises_an_exception_when_it_finds_an_invalid_character(MultibyteUtilsTest)
      test_verify_verifies_Shift-JIS_strings_are_properly_encoded(MultibyteUtilsTest)
      test_verify_verifies_UTF-8_strings_are_properly_encoded(MultibyteUtilsTest)
      test_each_after_yaml_serialization(OrderedHashTest)
      test_json(OrderedHashTest)
      test_order_after_yaml_serialization(OrderedHashTest)
      test_order_after_yaml_serialization_with_nested_arrays(OrderedHashTest)
      test_knows_whether_it_is_encoding_aware(OutputSafetyTest)
      test_camelize_lower(StringInflectionsTest)
      test_string_to_time(StringInflectionsTest)
      test_underscore_to_lower_camel(StringInflectionsTest)
      test_sprintf_lack_argument(TestGetTextString)
      test_json_decodes_[]_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_[{"d":"1970-01-01","s":"http:\/\/example.com"},{"d":"1970-01-01","s":"http:\/\/example.com"}]_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_[{"d":"1970-01-01",_"s":"\u0020escape"},{"d":"1970-01-01",_"s":"\u0020escape"}]_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_time_json_with_time_parsing_disabled(TestJSONDecoding)
      test_json_decodes_{"a":"\""}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":1}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_""}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"'",_"b":_"5,000"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"2007-01-01"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"2007-01-01_01:12:34"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"2007-01-01_01:12:34_Z"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"2007-01-01_:_it's_your_birthday"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"\\\\u0020skip_double_backslashes"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"\u003cbr_/\u003e"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"\u003cunicode\u0020escape\u003e"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"_2007-01-01_01:12:34_Z_"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"a's,_b's_and_c's",_"b":_"5,000"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_"http:\/\/test.host\/posts\/1"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_false}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_null}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"a":_true}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"b":["\u003ci\u003e","\u003cb\u003e","\u003cu\u003e"]}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"bad":"\\\\","trailing":""}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"matzue":_"松江",_"asakusa":_"浅草"}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"returnTo":[1,"\"a\",",_"b"]}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"returnTo":[1,"a"]}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"returnTo":{"\/categories":"\/"}}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"returnTo":{"\/categories":1}}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{"return\"To\":":{"\/categories":"\/"}}_with_the_JSONGem_backend(TestJSONDecoding)
      test_json_decodes_{}_with_the_JSONGem_backend(TestJSONDecoding)
      test_array(TestJSONEncoding)
      test_custom(TestJSONEncoding)
      test_date(TestJSONEncoding)
      test_date_time(TestJSONEncoding)
      test_hash_encoding(TestJSONEncoding)
      test_hash_key_identifiers_are_always_quoted(TestJSONEncoding)
      test_hash_should_allow_key_filtering_with_except(TestJSONEncoding)
      test_hash_should_allow_key_filtering_with_only(TestJSONEncoding)
      test_hash_with_time_to_json(TestJSONEncoding)
      test_hashlike(TestJSONEncoding)
      test_nested_hash_with_float(TestJSONEncoding)
      test_non_utf8_string_transcodes(TestJSONEncoding)
      test_numeric(TestJSONEncoding)
      test_object(TestJSONEncoding)
      test_regexp(TestJSONEncoding)
      test_standard_date(TestJSONEncoding)
      test_standard_date_time(TestJSONEncoding)
      test_standard_string(TestJSONEncoding)
      test_standard_time(TestJSONEncoding)
      test_string(TestJSONEncoding)
      test_symbol(TestJSONEncoding)
      test_time(TestJSONEncoding)
      test_utf8_string_encoded_properly_when_kcode_is_utf8(TestJSONEncoding)
      test_compare_with_datetime(TimeExtCalculationsTest)
      test_local_time(TimeExtCalculationsTest)
      test_since(TimeExtCalculationsTest)
      test_time_with_datetime_fallback(TimeExtCalculationsTest)
      test_to_datetime(TimeExtCalculationsTest)
      test_utc_time(TimeExtCalculationsTest)
      test_change(TimeWithZoneTest)
      test_compare_with_datetime(TimeWithZoneTest)
      test_ruby_19_weekday_name_query_methods(TimeWithZoneTest)
      test_to_datetime(TimeWithZoneTest)
      test_to_json_with_use_standard_json_time_format_config_set_to_false(TimeWithZoneTest)
      test_to_json_with_use_standard_json_time_format_config_set_to_true(TimeWithZoneTest)
      test_transliterate_should_approximate_ascii(TransliterateTest)
      test_transliterate_should_work_with_custom_i18n_rules_and_uncomposed_utf8(TransliterateTest)
    }
  end
end
