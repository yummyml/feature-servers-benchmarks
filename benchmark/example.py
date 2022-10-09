from datetime import datetime, timedelta
from feast import Entity, Field, FeatureView, FileSource, ValueType, FeatureService
from feast.types import Int32

generated_data_source = FileSource(
    path="./generated_data.parquet",
    timestamp_field="event_timestamp",
)

entity = Entity(
    name="entity",
    value_type=ValueType.INT64,
)

feature_views = [
    FeatureView(
        name=f"feature_view_{i}",
        entities=[entity],
        ttl=timedelta(seconds=86400),
        schema=[
            Field(name=f"feature_{10 * i + j}", dtype=Int32)
            for j in range(10)
        ],
        online=True,
        source=generated_data_source,
    )
    for i in range(25)
]

feature_services = [
    FeatureService(
        name=f"feature_service_{i}",
        features=feature_views[:5*(i + 1)],
    )
    for i in range(5)
]

def add_definitions_in_globals():
    for i, fv in enumerate(feature_views):
        globals()[f"feature_view_{i}"] = fv
    for i, fs in enumerate(feature_services):
        globals()[f"feature_service_{i}"] = fs

add_definitions_in_globals()
