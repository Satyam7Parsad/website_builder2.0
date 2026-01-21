-- ============================================================================
-- TEST DATA: Add Flexbox layout to existing template for testing
-- ============================================================================

-- Find a template with cards (SEC_CARDS = 4)
UPDATE sections
SET 
    display = 'flex',
    justify_content = 'space-between',
    align_items = 'center',
    flex_direction = 'row',
    gap = 40,
    padding_top = 80,
    padding_bottom = 80,
    padding_left = 60,
    padding_right = 60
WHERE type = 4  -- SEC_CARDS
  AND id IN (SELECT id FROM sections WHERE type = 4 LIMIT 3);

-- Show what we updated
SELECT 
    s.id,
    t.template_name,
    s.section_order,
    s.type,
    s.display,
    s.justify_content,
    s.align_items,
    s.gap
FROM sections s
JOIN templates t ON s.template_id = t.id
WHERE s.display = 'flex'
LIMIT 5;

\echo '✅ Test flexbox data added! Now reload a template in ImGui to see it work!'
