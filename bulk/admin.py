from django.contrib import admin
from .models import DataExport


@admin.register(DataExport)
class DataExportAdmin(admin.ModelAdmin):
    list_display = ("jurisdiction_name", "session_identifier", "created_at")

    def jurisdiction_name(self, m):
        return m.session.jurisdiction.name

    def session_identifier(self, m):
        return m.session.identifier
