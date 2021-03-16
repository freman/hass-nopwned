"""Helpers to check core security."""
from datetime import timedelta
from typing import List, Optional

from ...const import CoreState
from ...jobs.const import JobCondition, JobExecutionLimit
from ...jobs.decorator import Job
from ..const import ContextType, IssueType
from .base import CheckBase


class CheckAddonPwned(CheckBase):
    """CheckAddonPwned class for check."""

    @Job(
        conditions=[JobCondition.INTERNET_SYSTEM],
        limit=JobExecutionLimit.THROTTLE,
        throttle_period=timedelta(hours=24),
    )
    async def run_check(self) -> None:
        """Run check if not affected by issue."""

    @Job(conditions=[JobCondition.INTERNET_SYSTEM])
    async def approve_check(self, reference: Optional[str] = None) -> bool:
        """Approve check if it is affected by issue."""
        return False

    @property
    def issue(self) -> IssueType:
        """Return a IssueType enum."""
        return IssueType.PWNED

    @property
    def context(self) -> ContextType:
        """Return a ContextType enum."""
        return ContextType.ADDON

    @property
    def states(self) -> List[CoreState]:
        """Return a list of valid states when this check can run."""
        return [CoreState.RUNNING]
