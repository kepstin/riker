all:
	valac mb4_vapi_generator.vala --pkg libxml-2.0


LIB_NAME=libmusicbrainz4vala.so
lib:
	./mb4_vapi_generator cinterface.xml
	valac musicbrainz-4.0.vala --vapidir . --pkg libmusicbrainz4 --vapi musicbrainz-4.0.vapi --library $(LIB_NAME) -X -shared --pkg gee-1.0 -X -fPIC -o $(LIB_NAME) -H mb4_vala.h -g


sources: all
	./mb4_vapi_generator cinterface.xml
